//
//  MoviesRepositoryTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 04/04/2026.
//

import Testing
@testable import Movies

struct MoviesRepositoryTests {
    
    @Test func testDiscoverMoviesOnlineSuccess() async throws {
        let mockRemote = MockMoviesRemoteDataSource()
        let mockCache = MockMovieListDiskCache()
        let mockReachability = MockConnectivityStatusProvider(isSatisfied: true)
        
        let repo = MoviesRepository(
            remote: mockRemote,
            cache: mockCache,
            reachability: mockReachability
        )
        
        let result = try await repo.discoverMovies(page: 1, genreId: nil as String?, searchQuery: nil as String?)
        
        #expect(result.movies.count == 2)
        #expect(result.page == 1)
        
        let saveCount = await mockCache.getSaveCallCount()
        #expect(saveCount == 1)
    }
    
    @Test func testDiscoverMoviesOfflineWithCache() async throws {
        let mockRemote = MockMoviesRemoteDataSource()
        let mockCache = MockMovieListDiskCache(hasCachedData: true)
        let mockReachability = MockConnectivityStatusProvider(isSatisfied: false)
        
        let repo = MoviesRepository(
            remote: mockRemote,
            cache: mockCache,
            reachability: mockReachability
        )
        
        let result = try await repo.discoverMovies(page: 1, genreId: nil as String?, searchQuery: nil as String?)
        
        #expect(result.movies.count == 1)
        #expect(mockRemote.fetchCallCount == 0)
    }
    
    @Test func testDiscoverMoviesOfflineWithoutCache() async throws {
        let mockRemote = MockMoviesRemoteDataSource()
        let mockCache = MockMovieListDiskCache(hasCachedData: false)
        let mockReachability = MockConnectivityStatusProvider(isSatisfied: false)
        
        let repo = MoviesRepository(
            remote: mockRemote,
            cache: mockCache,
            reachability: mockReachability
        )
        
        let result = try await repo.discoverMovies(page: 1, genreId: nil as String?, searchQuery: nil as String?)
        
        #expect(result.movies.isEmpty)
    }
    
    @Test func testMovieGenresOnline() async throws {
        let mockRemote = MockMoviesRemoteDataSource()
        let mockCache = MockMovieListDiskCache()
        let mockReachability = MockConnectivityStatusProvider(isSatisfied: true)
        
        let repo = MoviesRepository(
            remote: mockRemote,
            cache: mockCache,
            reachability: mockReachability
        )
        
        let genres = try await repo.movieGenres()
        
        #expect(genres.count == 3)
        #expect(genres[0].name == "All")
        
        let saveCount = await mockCache.getSaveGenresCallCount()
        #expect(saveCount == 1)
    }
    
    @Test func testMovieDetails() async throws {
        let mockRemote = MockMoviesRemoteDataSource()
        let mockCache = MockMovieListDiskCache()
        let mockReachability = MockConnectivityStatusProvider(isSatisfied: true)
        
        let repo = MoviesRepository(
            remote: mockRemote,
            cache: mockCache,
            reachability: mockReachability
        )
        
        let detail = try await repo.movieDetails(movieId: 123)
        
        #expect(detail.id == 123)
        #expect(detail.title == "Test Movie")
    }
}
