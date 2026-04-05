//
//  MockGetMoviesUseCase.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Foundation
@testable import Movies

final class MockGetMoviesUseCase: GetMoviesUC {
    var shouldFail: Bool
    var executeCallCount = 0
    var lastParams: GetMoviesParams?
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func execute(with params: GetMoviesParams) async -> Result<PaginatedMoviesResult, Error> {
        executeCallCount += 1
        lastParams = params
        
        if shouldFail {
            return .failure(MockError.testError)
        }
        
        let result = PaginatedMoviesResult(
            movies: [
                Movie(id: 1, name: "Movie 1", posterPath: "/poster1.jpg", releaseYear: "2024", posterURL: nil),
                Movie(id: 2, name: "Movie 2", posterPath: "/poster2.jpg", releaseYear: "2023", posterURL: nil)
            ],
            page: params.page,
            totalPages: 5,
            totalResults: 100
        )
        
        return .success(result)
    }
}
