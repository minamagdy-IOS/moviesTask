//
//  MovieDetailViewModelTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Testing
@testable import Movies

@MainActor
struct MovieDetailViewModelTests {
    
    @Test func testLoadSuccess() async throws {
        let mockUseCase = MockGetMovieDetailsUseCase()
        let viewModel = MovieDetailViewModel(movieId: 123, useCase: mockUseCase)
        
        await viewModel.load()
        
        #expect(viewModel.movieDetail != nil)
        #expect(viewModel.movieDetail?.id == 123)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func testLoadFailure() async throws {
        let mockUseCase = MockGetMovieDetailsUseCase(shouldFail: true)
        let viewModel = MovieDetailViewModel(movieId: 123, useCase: mockUseCase)
        
        await viewModel.load()
        
        #expect(viewModel.movieDetail == nil)
        #expect(viewModel.errorMessage == "Could not load movie details.")
    }
    
    @Test func testGenresDisplay() async throws {
        let mockUseCase = MockGetMovieDetailsUseCase()
        let viewModel = MovieDetailViewModel(movieId: 123, useCase: mockUseCase)
        
        await viewModel.load()
        
        #expect(viewModel.genresDisplay == "Action, Adventure")
    }
    
    @Test func testGenresDisplayEmpty() async throws {
        let mockUseCase = MockGetMovieDetailsUseCase(emptyGenres: true)
        let viewModel = MovieDetailViewModel(movieId: 123, useCase: mockUseCase)
        
        await viewModel.load()
        
        #expect(viewModel.genresDisplay == "—")
    }
    
    @Test func testBudgetDisplay() async throws {
        let mockUseCase = MockGetMovieDetailsUseCase()
        let viewModel = MovieDetailViewModel(movieId: 123, useCase: mockUseCase)
        
        await viewModel.load()
        
        #expect(viewModel.budgetDisplay.contains("100,000,000"))
    }
    
    @Test func testBudgetDisplayZero() async throws {
        let mockUseCase = MockGetMovieDetailsUseCase(zeroBudget: true)
        let viewModel = MovieDetailViewModel(movieId: 123, useCase: mockUseCase)
        
        await viewModel.load()
        
        #expect(viewModel.budgetDisplay == "—")
    }
    
    @Test func testRuntimeDisplay() async throws {
        let mockUseCase = MockGetMovieDetailsUseCase()
        let viewModel = MovieDetailViewModel(movieId: 123, useCase: mockUseCase)
        
        await viewModel.load()
        
        #expect(viewModel.runtimeDisplay == "120 minutes")
    }
    
    @Test func testRuntimeDisplayNil() async throws {
        let mockUseCase = MockGetMovieDetailsUseCase(nilRuntime: true)
        let viewModel = MovieDetailViewModel(movieId: 123, useCase: mockUseCase)
        
        await viewModel.load()
        
        #expect(viewModel.runtimeDisplay == "—")
    }
}
