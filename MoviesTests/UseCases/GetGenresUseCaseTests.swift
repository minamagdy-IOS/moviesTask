//
//  GetGenresUseCaseTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Testing
@testable import Movies

struct GetGenresUseCaseTests {
    
    @Test func testExecuteSuccess() async throws {
        let mockRepo = MockMoviesRepository()
        let useCase = GetGenresUseCase(repository: mockRepo)
        
        let result = await useCase.execute()
        
        guard case .success(let genres) = result else {
            Issue.record("Expected success")
            return
        }
        
        #expect(genres.count == 3)
        #expect(genres[0].name == "All")
    }
    
    @Test func testExecuteFailure() async throws {
        let mockRepo = MockMoviesRepository(shouldFail: true)
        let useCase = GetGenresUseCase(repository: mockRepo)
        
        let result = await useCase.execute()
        
        guard case .failure = result else {
            Issue.record("Expected failure")
            return
        }
    }
}
