//
//  StaffView.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import SwiftUI
import SwiftData

struct StaffView: View {
    @StateObject private var viewModel: StaffViewModel
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var items: [StaffPageData]
    
    private var allStaffs: [Staff] { items.flatMap { $0.data } }
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: StaffViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        VStack {
            Text("Staff List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            List {
                ForEach(allStaffs) { staff in
                                        VStack(alignment: .leading) {
                                    
                                    AsyncImage(url: URL(string: staff.avatar))
                                    
                                    HStack {
                                        Text(staff.firstName)
                                            .font(.headline)
                                        Text(staff.lastName)
                                            .font(.headline)
                                    }
                                    
                                    Text(staff.email)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                }
                            }
                
                Button(action: viewModel.loadMoreStaff) {
                                Text("Load more")
                }
                }
            }
            
        }
}
