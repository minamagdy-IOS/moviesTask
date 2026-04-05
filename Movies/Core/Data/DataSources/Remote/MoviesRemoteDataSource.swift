//
//  MoviesRemoteDataSource.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//


import Foundation

protocol MoviesRemoteDataSourceProtocol: Sendable {
    func fetchDiscoverMovies(page: Int, genreId: String?) async throws -> PaginatedResponseDTO<MovieDTO>
    func searchMovies(query: String, page: Int) async throws -> PaginatedResponseDTO<MovieDTO>
    func fetchMovieGenres() async throws -> GenreListResponseDTO
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetailDTO
}

struct MoviesRemoteDataSource: MoviesRemoteDataSourceProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol) {
        self.client = client
    }

    func fetchDiscoverMovies(page: Int, genreId: String?) async throws -> PaginatedResponseDTO<MovieDTO> {
        let url = try MoviesAPIEndpoints.discoverMovies(page: page, withGenreId: genreId)
        return try await decode(PaginatedResponseDTO<MovieDTO>.self, url: url)
    }

    func searchMovies(query: String, page: Int) async throws -> PaginatedResponseDTO<MovieDTO> {
        let url = try MoviesAPIEndpoints.searchMovies(query: query, page: page)
        return try await decode(PaginatedResponseDTO<MovieDTO>.self, url: url)
    }

    func fetchMovieGenres() async throws -> GenreListResponseDTO {
        let url = try MoviesAPIEndpoints.movieGenres()
        return try await decode(GenreListResponseDTO.self, url: url)
    }

    func fetchMovieDetails(movieId: Int) async throws -> MovieDetailDTO {
        let url = try MoviesAPIEndpoints.movieDetail(movieId: movieId)
        return try await decode(MovieDetailDTO.self, url: url)
    }

    private func decode<T: Decodable>(_ type: T.Type, url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let data = try await client.fetchData(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
