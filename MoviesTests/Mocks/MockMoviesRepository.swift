//
//  MockMoviesRepository.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Foundation
@testable import Movies

enum MockError: Error {
    case testError
}

final class MockMoviesRepository: MoviesRepositoryProtocol {
    var shouldFail: Bool
    var lastGenreId: String?
    var lastSearchQuery: String?
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func discoverMovies(page: Int, genreId: String?, searchQuery: String?) async throws -> PaginatedMoviesResult {
        lastGenreId = genreId
        lastSearchQuery = searchQuery
        
        if shouldFail {
            throw MockError.testError
        }
        
        return PaginatedMoviesResult(
            movies: [
                Movie(id: 1, name: "Movie 1", posterPath: "/poster1.jpg", releaseYear: "2024", posterURL: nil),
                Movie(id: 2, name: "Movie 2", posterPath: "/poster2.jpg", releaseYear: "2023", posterURL: nil)
            ],
            page: page,
            totalPages: 5,
            totalResults: 100
        )
    }
    
    func movieGenres() async throws -> [Genre] {
        if shouldFail {
            throw MockError.testError
        }
        
        return [
            Genre(tmdbId: nil, name: "All"),
            Genre(tmdbId: 28, name: "Action"),
            Genre(tmdbId: 35, name: "Comedy")
        ]
    }
    
    func movieDetails(movieId: Int) async throws -> MovieDetail {
        if shouldFail {
            throw MockError.testError
        }
        
        return MovieDetail(
            id: movieId,
            title: "Test Movie",
            posterURL: nil,
            backdropURL: nil,
            year: "2024",
            genres: ["Action", "Adventure"],
            overview: "Test overview",
            homepage: "https://example.com",
            budget: 100_000_000,
            revenue: 500_000_000,
            spokenLanguages: ["English", "Spanish"],
            status: "Released",
            runtime: 120
        )
    }
}
