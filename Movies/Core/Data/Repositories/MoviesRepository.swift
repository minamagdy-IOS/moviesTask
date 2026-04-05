//
//  MoviesRepository.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

struct MoviesRepository: MoviesRepositoryProtocol {
    private let remote: MoviesRemoteDataSourceProtocol
    private let cache: MovieListDiskCaching
    private let reachability: ReachabilityService

    init(
        remote: MoviesRemoteDataSourceProtocol,
        cache: MovieListDiskCaching,
        reachability: ReachabilityService
    ) {
        self.remote = remote
        self.cache = cache
        self.reachability = reachability
    }

    func discoverMovies(page: Int, genreId: String?, searchQuery: String?) async throws -> PaginatedMoviesResult {
        let key = Self.moviesCacheKey(page: page, genreId: genreId, searchQuery: searchQuery)
        if !reachability.isSatisfied() {
            if let cached = try await cache.loadMoviesPage(key: key) { return cached }
            return PaginatedMoviesResult(movies: [], page: page, totalPages: page, totalResults: 0)
        }
        do {
            let result = try await loadFromRemote(page: page, genreId: genreId, searchQuery: searchQuery)
            try await cache.saveMoviesPage(result, key: key)
            return result
        } catch {
            if let cached = try await cache.loadMoviesPage(key: key) { return cached }
            throw error
        }
    }

    func movieGenres() async throws -> [Genre] {
        if !reachability.isSatisfied() {
            if let cached = try await cache.loadGenres(), !cached.isEmpty { return cached }
            return [Genre(tmdbId: nil, name: "All")]
        }
        do {
            let response = try await remote.fetchMovieGenres()
            let genres = [Genre(tmdbId: nil, name: "All")] + (response.genres ?? []).map { GenreMapper.toDomain($0) }
            try await cache.saveGenres(genres)
            return genres
        } catch {
            if let cached = try await cache.loadGenres(), !cached.isEmpty { return cached }
            return [Genre(tmdbId: nil, name: "All")]
        }
    }

    func movieDetails(movieId: Int) async throws -> MovieDetail {
        let dto = try await remote.fetchMovieDetails(movieId: movieId)
        guard let detail = MovieDetailMapper.toDomain(dto) else {
            throw NetworkError.decodingFailed
        }
        return detail
    }

    // MARK: - Private

    private func loadFromRemote(page: Int, genreId: String?, searchQuery: String?) async throws -> PaginatedMoviesResult {
        let response: PaginatedResponseDTO<MovieDTO>
        if let query = searchQuery, !query.isEmpty {
            response = try await remote.searchMovies(query: query, page: page)
        } else {
            response = try await remote.fetchDiscoverMovies(page: page, genreId: genreId)
        }
        let movies = (response.results ?? []).compactMap { MovieMapper.toDomain($0) }
        return PaginatedMoviesResult(
            movies: movies,
            page: response.page,
            totalPages: response.totalPages,
            totalResults: response.totalResults
        )
    }

    private static func moviesCacheKey(page: Int, genreId: String?, searchQuery: String?) -> String {
        "\(page)|\(genreId ?? "")|\(searchQuery ?? "")"
    }
}
