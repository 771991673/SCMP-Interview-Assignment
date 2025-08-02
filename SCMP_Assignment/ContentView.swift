//
//  ContentView.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
    @EnvironmentObject private var router: Router

    
    var body: some View {
        NavigationStack(path: $router.path) {
                LoginView(router: router)
//            StaffView(modelContext: modelContext)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginView(router: router)
                    case .staffList:
                        StaffView(modelContext: modelContext)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
