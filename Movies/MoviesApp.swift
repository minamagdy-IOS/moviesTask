//
//  MoviesApp.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import SwiftUI
import SwiftData

@main
struct MoviesApp: App {
    @MainActor
    init() {
        Resolver.bootstrapIfNeeded()
    }

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CachedMovieDetail.self,
            UserPreferences.self
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
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
