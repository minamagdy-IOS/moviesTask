//
//  GetMovieDetailsUseCase.swift
//  Movies
//
//  Created by Mina Magdy on 02/04/2026.
//

import Foundation

protocol GetMovieDetailsUC: Sendable {
    func execute(movieId: Int) async -> Result<MovieDetail, Error>
}

struct GetMovieDetailsUseCase: GetMovieDetailsUC {
    private let repository: MoviesRepositoryProtocol

    init(repository: MoviesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(movieId: Int) async -> Result<MovieDetail, Error> {
        do {
            let detail = try await repository.movieDetails(movieId: movieId)
            return .success(detail)
        } catch {
            return .failure(error)
        }
    }
}
