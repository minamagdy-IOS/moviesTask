//
//  MovieMapperTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 04/04/2026.
//

import Testing
@testable import Movies

struct MovieMapperTests {
    
    @Test func testToDomainSuccess() throws {
        let dto = MovieDTO(
            id: 123,
            posterPath: "/poster.jpg",
            releaseDate: "2024-03-15",
            title: "Test Movie",
        )
        
        let movie = MovieMapper.toDomain(dto)
        
        #expect(movie != nil)
        #expect(movie?.id == 123)
        #expect(movie?.name == "Test Movie")
        #expect(movie?.releaseYear == "2024")
    }
    
    @Test func testToDomainWithMissingId() throws {
        let dto = MovieDTO(id: nil, title: "Test Movie")
        let movie = MovieMapper.toDomain(dto)
        
        #expect(movie == nil)
    }
    
    @Test func testToDomainUsesUntitledAsFallback() throws {
        let dto = MovieDTO(id: 123, title: nil)
        let movie = MovieMapper.toDomain(dto)
        
        #expect(movie?.name == "Untitled")
    }
}
