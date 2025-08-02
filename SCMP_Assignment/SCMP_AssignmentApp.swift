//
//  SCMP_AssignmentApp.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import SwiftUI
import SwiftData

@main
struct SCMP_AssignmentApp: App {
    
    @StateObject private var router = Router()
    @Environment(\.modelContext) private var modelContext
    
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            StaffPageData.self

        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .uiManager()
                .environmentObject(router)
        }
        .modelContainer(sharedModelContainer)
    }
}
