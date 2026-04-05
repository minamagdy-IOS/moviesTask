//
//  MockMoviesRemoteDataSource.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Foundation
@testable import Movies

final class MockMoviesRemoteDataSource: MoviesRemoteDataSourceProtocol {
    var shouldFail: Bool
    var fetchCallCount = 0
    var fetchGenresCallCount = 0
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func fetchDiscoverMovies(page: Int, genreId: String?) async throws -> PaginatedResponseDTO<MovieDTO> {
        fetchCallCount += 1
        
        if shouldFail {
            throw MockError.testError
        }
        
        return PaginatedResponseDTO(
            page: page,
            totalPages: 5,
            totalResults: 100,
            results: [
                MovieDTO(id: 1, posterPath: "/poster1.jpg",releaseDate: "2024-01-01", title: "Movie 1"),
                MovieDTO(id: 1, posterPath: "/poster2.jpg",releaseDate: "2024-01-02", title: "Movie 2"),
            ]
        )
    }
    
    func searchMovies(query: String, page: Int) async throws -> PaginatedResponseDTO<MovieDTO> {
        fetchCallCount += 1
        
        if shouldFail {
            throw MockError.testError
        }
        
        return PaginatedResponseDTO(
            page: page,
            totalPages: 2,
            totalResults: 20,
            results: [
                MovieDTO(id: 3, posterPath: "/poster3.jpg", releaseDate: "2024-01-01", title: query)
            ]
        )
    }
    
    func fetchMovieGenres() async throws -> GenreListResponseDTO {
        fetchGenresCallCount += 1
        
        if shouldFail {
            throw MockError.testError
        }
        
        return GenreListResponseDTO(genres: [
            GenreDTO(id: 28, name: "Action"),
            GenreDTO(id: 35, name: "Comedy")
        ])
    }
    
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetailDTO {
        if shouldFail {
            throw MockError.testError
        }
        
        var dto = MovieDetailDTO()
        dto.id = movieId
        dto.title = "Test Movie"
        dto.overview = "Test overview"
        dto.releaseDate = "2024-01-01"
        dto.runtime = 120
        dto.budget = 100_000_000
        dto.revenue = 500_000_000
        dto.status = "Released"
        dto.spokenLanguages = [
            SpokenLanguageDTO(englishName: "English", name: "English")
        ]
        dto.genres = [
            GenreDTO(id: 28, name: "Action"),
            GenreDTO(id: 12, name: "Adventure")
        ]
        return dto
    }
}
