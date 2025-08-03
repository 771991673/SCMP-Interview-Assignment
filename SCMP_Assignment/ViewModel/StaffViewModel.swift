//
//  StaffViewModel.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//


import Foundation
import Combine
import SwiftData

class StaffViewModel: ObservableObject {
    private var modelContext: ModelContext
    
    @Published var allStaffs: [Staff] = []
    
    @Published var errorMessage: String? {
        didSet {
            if let errorMessage = errorMessage {
                UIManager.shared.showToast(message: errorMessage)
            }
        }
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    
    func savePageData(data: StaffInfoResponse) async {
        do {
            let fetchDescriptor = FetchDescriptor<StaffPageData>(
                predicate: #Predicate { $0.page == data.page }
            )
            let existing = try modelContext.fetch(fetchDescriptor)
            
            if !existing.isEmpty {
                errorMessage = "A record with page \(data.page) already exists"
                return
            }
            
            let staffInfoData = StaffPageData(page: data.page, perPage: data.perPage, total: data.total, totalPages: data.totalPages, data: data.data, support: data.support)
            modelContext.insert(staffInfoData)
            try modelContext.save()
        } catch {
            errorMessage = "Exception while inserting data"
        }
    }
    
    func loadAllStaffs() async  {
        let staffs = await fetchAllPages().flatMap { $0.data }
        
        await MainActor.run {
            allStaffs = staffs
        }
    }
    
    func fetchAllPages() async -> [StaffPageData]  {
        do {
            let fetchDescriptor = FetchDescriptor<StaffPageData>(
                sortBy: [SortDescriptor(\.page, order: .forward)]
            )
            
            let results = try modelContext.fetch(fetchDescriptor)
            return results
        } catch {
            errorMessage = "Failed to fetch Staff Page Data: \(error)"
            return []
        }
    }
    
    func fetchGreatestPage() async -> StaffPageData? {
        do {
            var fetchDescriptor = FetchDescriptor<StaffPageData>(
                sortBy: [SortDescriptor(\.page, order: .reverse)]
            )
            fetchDescriptor.fetchLimit = 1
            
            let results = try modelContext.fetch(fetchDescriptor)
            return results.first
        } catch {
            errorMessage = "Failed to fetch greatest page: \(error)"
            return nil
        }
    }
    
    
    func loadMoreStaff() async {
        var nextPageID = 1
        
        if let greatestPage = await fetchGreatestPage() {
            nextPageID = greatestPage.page + 1
            
            if nextPageID > greatestPage.totalPages {
                await MainActor.run {
                    errorMessage = "Reach the maximum page"
                }
                return
            }
        }
        
        do {
            let pageData = try await NetworkManager.shared.performRequest(.getStaffPage(num: nextPageID))
            debugPrint("fetching page \(nextPageID)")
            await savePageData(data: pageData)
            
            await MainActor.run {
                allStaffs.append(contentsOf: pageData.data)
            }
        } catch {
            errorMessage = "Network Error \(error.localizedDescription)"
        }
    }
}
