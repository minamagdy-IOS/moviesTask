//
//  GetMoviesUseCaseTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Testing
@testable import Movies

struct GetMoviesUseCaseTests {
    
    @Test func testExecuteSuccess() async throws {
        let mockRepo = MockMoviesRepository()
        let useCase = GetMoviesUseCase(repository: mockRepo)
        
        let params = GetMoviesParams(page: 1, searchKey: nil, genre: "")
        let result = await useCase.execute(with: params)
        
        guard case .success(let data) = result else {
            Issue.record("Expected success")
            return
        }
        
        #expect(data.movies.count == 2)
        #expect(data.page == 1)
    }
    
    @Test func testExecuteWithGenreFilter() async throws {
        let mockRepo = MockMoviesRepository()
        let useCase = GetMoviesUseCase(repository: mockRepo)
        
        let params = GetMoviesParams(page: 1, searchKey: nil, genre: "28")
        let result = await useCase.execute(with: params)
        
        guard case .success = result else {
            Issue.record("Expected success")
            return
        }
        
        #expect(mockRepo.lastGenreId == "28")
    }
    
    @Test func testExecuteFailure() async throws {
        let mockRepo = MockMoviesRepository(shouldFail: true)
        let useCase = GetMoviesUseCase(repository: mockRepo)
        
        let params = GetMoviesParams(page: 1, searchKey: nil, genre: "")
        let result = await useCase.execute(with: params)
        
        guard case .failure = result else {
            Issue.record("Expected failure")
            return
        }
    }
}
