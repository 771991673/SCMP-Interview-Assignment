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
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: StaffViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        VStack {
            Text("Staff List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if let savedToken = KeychainHelper.getJWT(forKey: "token") {
                Text(savedToken)
                    .font(.headline)
            }
            
            List {
                ForEach(viewModel.allStaffs, id: \.id) { staff in
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
                                .onAppear {
                                    print("Rendering item: \(staff.firstName)")
                                }
                            }
                    
                    Button(action: {
                        Task {
                            await viewModel.loadMoreStaff()
                        }
                    }) { Text("Load more") }
                }
            }
        .onAppear {
            viewModel.loadAllStaffs()

            Task {
                await viewModel.loadMoreStaff()
            }
            
        }
            
        }
}
