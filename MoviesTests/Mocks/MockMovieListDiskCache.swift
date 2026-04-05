//
//  MockMovieListDiskCache.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Foundation
@testable import Movies

actor MockMovieListDiskCache: MovieListDiskCaching {
    private var hasCachedData: Bool
    private var hasCachedGenres: Bool
    private var _saveCallCount = 0
    private var _saveGenresCallCount = 0
    
    init(hasCachedData: Bool = false, hasCachedGenres: Bool = false) {
        self.hasCachedData = hasCachedData
        self.hasCachedGenres = hasCachedGenres
    }
    
    func saveMoviesPage(_ result: PaginatedMoviesResult, key: String) async throws {
        _saveCallCount += 1
    }
    
    func loadMoviesPage(key: String) async throws -> PaginatedMoviesResult? {
        guard hasCachedData else { return nil }
        
        return PaginatedMoviesResult(
            movies: [
                Movie(id: 10, name: "Cached Movie", posterPath: nil, releaseYear: "2023", posterURL: nil)
            ],
            page: 1,
            totalPages: 1,
            totalResults: 1
        )
    }
    
    func saveGenres(_ genres: [Genre]) async throws {
        _saveGenresCallCount += 1
    }
    
    func loadGenres() async throws -> [Genre]? {
        guard hasCachedGenres else { return nil }
        
        return [
            Genre(tmdbId: nil, name: "All"),
            Genre(tmdbId: 28, name: "Cached Action")
        ]
    }
    
    // Public getters for test verification
    func getSaveCallCount() async -> Int { _saveCallCount }
    func getSaveGenresCallCount() async -> Int { _saveGenresCallCount }
}
