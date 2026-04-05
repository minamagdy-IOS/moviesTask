//
//  MovieMapper.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

enum MovieMapper {
    static func toDomain(_ dto: MovieDTO) -> Movie? {
        guard let id = dto.id else { return nil }
        let title = dto.title ?? dto.originalTitle ?? "Untitled"
        let year: String? = {
            guard let releaseDate = dto.releaseDate, releaseDate.count >= 4 else { return nil }
            return String(releaseDate.prefix(4))
        }()
        let posterURL = APIConstants.tmdbImageURL(path: dto.posterPath, size: APIConstants.posterSizeList)
        return Movie(id: id, name: title, posterPath: dto.posterPath, releaseYear: year, posterURL: posterURL)
    }
}
