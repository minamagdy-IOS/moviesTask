//
//  UserPreferences.swift
//  Movies
//
//  Created by Mina Magdy on 02/04/2026.
//

import Foundation
import SwiftData

@Model
final class UserPreferences: @unchecked Sendable {
    @Attribute(.unique) var id: String = "main"
    var lastSelectedGenreIndex: Int
    var searchHistory: [String]
    var maxSearchHistoryCount: Int
    var lastUpdated: Date

    init(
        lastSelectedGenreIndex: Int = 0,
        searchHistory: [String] = [],
        maxSearchHistoryCount: Int = 10,
        lastUpdated: Date = .now
    ) {
        self.lastSelectedGenreIndex = lastSelectedGenreIndex
        self.searchHistory = searchHistory
        self.maxSearchHistoryCount = maxSearchHistoryCount
        self.lastUpdated = lastUpdated
    }

    func addSearchTerm(_ term: String) {
        let trimmed = term.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        // Remove if already exists
        searchHistory.removeAll { $0.lowercased() == trimmed.lowercased() }
        
        // Add to front
        searchHistory.insert(trimmed, at: 0)
        
        // Limit size
        if searchHistory.count > maxSearchHistoryCount {
            searchHistory = Array(searchHistory.prefix(maxSearchHistoryCount))
        }
        
        lastUpdated = .now
    }
}