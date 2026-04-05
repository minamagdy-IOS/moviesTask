//
//  MovieDetailMapperTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 04/04/2026.
//

import Testing
@testable import Movies

struct MovieDetailMapperTests {
    
    @Test func testToDomainSuccess() throws {
        var dto = MovieDetailDTO()
        dto.id = 123
        dto.title = "Test Movie"
        dto.overview = "Test overview"
        dto.releaseDate = "2024-03-15"
        dto.runtime = 120
        dto.budget = 100_000_000
        dto.revenue = 500_000_000
        dto.status = "Released"
        dto.genres = [
            GenreDTO(id: 28, name: "Action"),
            GenreDTO(id: 12, name: "Adventure")
        ]
        
        let detail = MovieDetailMapper.toDomain(dto)
        
        #expect(detail != nil)
        #expect(detail?.id == 123)
        #expect(detail?.title == "Test Movie")
        #expect(detail?.genres == ["Action", "Adventure"])
        #expect(detail?.runtime == 120)
    }
    
    @Test func testToDomainWithMissingId() throws {
        var dto = MovieDetailDTO()
        dto.id = nil
        dto.title = "Test"
        let detail = MovieDetailMapper.toDomain(dto)
        
        #expect(detail == nil)
    }
    
    @Test func testToDomainHandlesEmptyGenres() throws {
        var dto = MovieDetailDTO()
        dto.id = 123
        dto.title = "Test"
        dto.genres = []
        let detail = MovieDetailMapper.toDomain(dto)
        
        #expect(detail?.genres.isEmpty == true)
    }
}
