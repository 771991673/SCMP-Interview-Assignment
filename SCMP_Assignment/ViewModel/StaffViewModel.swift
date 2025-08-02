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
    @Published var staffMemberPage: [StaffPageData] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchStaff()
    }
    
    func fetchStaff() {
//        TODO: load staff locally for initialization
        

    }
    
    func loadMoreStaff() {
        if let lastPage = staffMemberPage.last {
            let maximumID = lastPage.page
        }
    }
}
