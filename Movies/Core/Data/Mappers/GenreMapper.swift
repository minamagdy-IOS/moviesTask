//
//  GenreMapper.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

enum GenreMapper {
    static func toDomain(_ dto: GenreDTO) -> Genre {
        Genre(tmdbId: dto.id, name: dto.name)
    }
}
