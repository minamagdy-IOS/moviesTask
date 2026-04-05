//
//  GetMovieDetailsUseCaseTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Testing
@testable import Movies

struct GetMovieDetailsUseCaseTests {
    
    @Test func testExecuteSuccess() async throws {
        let mockRepo = MockMoviesRepository()
        let useCase = GetMovieDetailsUseCase(repository: mockRepo)
        
        let result = await useCase.execute(movieId: 123)
        
        guard case .success(let detail) = result else {
            Issue.record("Expected success")
            return
        }
        
        #expect(detail.id == 123)
        #expect(detail.title == "Test Movie")
    }
    
    @Test func testExecuteFailure() async throws {
        let mockRepo = MockMoviesRepository(shouldFail: true)
        let useCase = GetMovieDetailsUseCase(repository: mockRepo)
        
        let result = await useCase.execute(movieId: 123)
        
        guard case .failure = result else {
            Issue.record("Expected failure")
            return
        }
    }
}
