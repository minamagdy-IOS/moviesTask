//
//  MockGetMovieDetailsUseCase.swift
//  MoviesTests
//
//  Created by Mina Magdy on 04/04/2026.
//

import Foundation
@testable import Movies

final class MockGetMovieDetailsUseCase: GetMovieDetailsUC {
    var shouldFail: Bool
    var emptyGenres: Bool
    var zeroBudget: Bool
    var nilRuntime: Bool
    var executeCallCount = 0
    
    init(
        shouldFail: Bool = false,
        emptyGenres: Bool = false,
        zeroBudget: Bool = false,
        nilRuntime: Bool = false
    ) {
        self.shouldFail = shouldFail
        self.emptyGenres = emptyGenres
        self.zeroBudget = zeroBudget
        self.nilRuntime = nilRuntime
    }
    
    func execute(movieId: Int) async -> Result<MovieDetail, Error> {
        executeCallCount += 1
        
        if shouldFail {
            return .failure(MockError.testError)
        }
        
        let detail = MovieDetail(
            id: movieId,
            title: "Test Movie",
            posterURL: nil,
            backdropURL: nil,
            year: "2024",
            genres: emptyGenres ? [] : ["Action", "Adventure"],
            overview: "Test overview",
            homepage: "https://example.com",
            budget: zeroBudget ? 0 : 100_000_000,
            revenue: 500_000_000,
            spokenLanguages: ["English", "Spanish"],
            status: "Released",
            runtime: nilRuntime ? nil : 120
        )
        
        return .success(detail)
    }
}
