//
//  ContentView.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [CachedMovieDetail.self, UserPreferences.self], inMemory: true)
}