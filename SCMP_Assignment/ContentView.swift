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
    @EnvironmentObject private var router: Router

    
    var body: some View {
        NavigationStack(path: $router.path) {
                LoginView(router: router)
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
        .modelContainer(for: StaffPageData.self, inMemory: true)
}
