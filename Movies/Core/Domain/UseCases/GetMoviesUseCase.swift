//
//  GetMoviesUseCase.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

struct GetMoviesParams: Sendable {
    let page: Int
    let searchKey: String?
    let genre: String
}

protocol GetMoviesUC: Sendable {
    func execute(with params: GetMoviesParams) async -> Result<PaginatedMoviesResult, Error>
}

struct GetMoviesUseCase: GetMoviesUC {
    private let repository: MoviesRepositoryProtocol

    init(repository: MoviesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(with params: GetMoviesParams) async -> Result<PaginatedMoviesResult, Error> {
        do {
            let genreFilter = params.genre.isEmpty ? nil : params.genre
            let result = try await repository.discoverMovies(
                page: params.page,
                genreId: genreFilter,
                searchQuery: params.searchKey
            )
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
