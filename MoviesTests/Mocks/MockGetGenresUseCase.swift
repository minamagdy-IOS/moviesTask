//
//  MockGetGenresUseCase.swift
//  MoviesTests
//
//  Created by Mina Magdy on 04/04/2026.
//

import Foundation
@testable import Movies

final class MockGetGenresUseCase: GetGenresUC {
    var shouldFail: Bool
    var executeCallCount = 0
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func execute() async -> Result<[Genre], Error> {
        executeCallCount += 1
        
        if shouldFail {
            return .failure(MockError.testError)
        }
        
        let genres = [
            Genre(tmdbId: nil, name: "All"),
            Genre(tmdbId: 28, name: "Action"),
            Genre(tmdbId: 35, name: "Comedy")
        ]
        
        return .success(genres)
    }
}
