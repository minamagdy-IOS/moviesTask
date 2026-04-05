//
//  GetGenresUseCase.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

protocol GetGenresUC: Sendable {
    func execute() async -> Result<[Genre], Error>
}

struct GetGenresUseCase: GetGenresUC {
    private let repository: MoviesRepositoryProtocol

    init(repository: MoviesRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async -> Result<[Genre], Error> {
        do {
            return .success(try await repository.movieGenres())
        } catch {
            return .failure(error)
        }
    }
}
