//
//  MoviesRepositoryProtocol.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

/// The domain contract for movies data. Defined in the Domain layer so
/// Use Cases depend on this abstraction, not on any Data-layer concrete type.
protocol MoviesRepositoryProtocol: Sendable {
    func discoverMovies(page: Int, genreId: String?, searchQuery: String?) async throws -> PaginatedMoviesResult
    func movieGenres() async throws -> [Genre]
    func movieDetails(movieId: Int) async throws -> MovieDetail
}

// MARK: - Domain result type for paginated movies
struct PaginatedMoviesResult: Sendable, Codable {
    let movies: [Movie]
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
}
