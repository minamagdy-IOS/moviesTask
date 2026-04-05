//
//  HomeViewModelTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 05/04/2026.
//

import Testing
@testable import Movies

@MainActor
struct HomeViewModelTests {
    
    @Test func testLoadMoviesSuccess() async throws {
        let mockMoviesUC = MockGetMoviesUseCase()
        let mockGenresUC = MockGetGenresUseCase()
        let mockReachability = MockConnectivityStatusProvider()
        
        let viewModel = HomeViewModel(
            getMoviesUseCase: mockMoviesUC,
            getGenresUseCase: mockGenresUC,
            reachability: mockReachability
        )
        
        await viewModel.loadMovies(from: 1)
        
        #expect(viewModel.movies.count == 2)
    }
    
    @Test func testLoadMoviesWithGenreFilter() async throws {
        let mockMoviesUC = MockGetMoviesUseCase()
        let mockGenresUC = MockGetGenresUseCase()
        let mockReachability = MockConnectivityStatusProvider()
        
        let viewModel = HomeViewModel(
            getMoviesUseCase: mockMoviesUC,
            getGenresUseCase: mockGenresUC,
            reachability: mockReachability
        )
        
        await viewModel.loadMovies(from: 1, genreOverride: "28")
        
        #expect(viewModel.selectedGenre == "28")
    }
    
    @Test func testGetGenres() async throws {
        let mockMoviesUC = MockGetMoviesUseCase()
        let mockGenresUC = MockGetGenresUseCase()
        let mockReachability = MockConnectivityStatusProvider()
        
        let viewModel = HomeViewModel(
            getMoviesUseCase: mockMoviesUC,
            getGenresUseCase: mockGenresUC,
            reachability: mockReachability
        )
        
        await viewModel.getGenre()
        
        #expect(viewModel.genre.count == 3)
        #expect(viewModel.genre[0].name == "All")
    }
    
    @Test func testGenreIdString() async throws {
        let mockMoviesUC = MockGetMoviesUseCase()
        let mockGenresUC = MockGetGenresUseCase()
        let mockReachability = MockConnectivityStatusProvider()
        
        let viewModel = HomeViewModel(
            getMoviesUseCase: mockMoviesUC,
            getGenresUseCase: mockGenresUC,
            reachability: mockReachability
        )
        
        await viewModel.getGenre()
        
        let genreId = viewModel.genreIdString(at: 1)
        #expect(genreId == "28")
    }
    
    @Test func testIsOnlineStatus() async throws {
        let mockMoviesUC = MockGetMoviesUseCase()
        let mockGenresUC = MockGetGenresUseCase()
        let mockReachability = MockConnectivityStatusProvider(isSatisfied: false)
        
        let viewModel = HomeViewModel(
            getMoviesUseCase: mockMoviesUC,
            getGenresUseCase: mockGenresUC,
            reachability: mockReachability
        )
        
        #expect(viewModel.isOnline == false)
    }
}
