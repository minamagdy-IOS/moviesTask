//
//  GenreMapperTests.swift
//  MoviesTests
//
//  Created by Mina Magdy on 04/04/2026.
//

import Testing
@testable import Movies

struct GenreMapperTests {
    
    @Test func testToDomain() throws {
        let dto = GenreDTO(id: 28, name: "Action")
        let genre = GenreMapper.toDomain(dto)
        
        #expect(genre.id == 28)
        #expect(genre.name == "Action")
    }
    
    @Test func testToDomainWithNilId() throws {
        let dto = GenreDTO(id: nil, name: "All")
        let genre = GenreMapper.toDomain(dto)
        
        #expect(genre.id == Genre.allGenresId)
        #expect(genre.tmdbId == nil)
    }
}
