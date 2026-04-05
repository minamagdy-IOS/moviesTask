//
//  MovieDetailMapper.swift
//  Movies
//
//  Created by Mina Magdy on 02/04/2026.
//

import Foundation

enum MovieDetailMapper {
    static func toDomain(_ dto: MovieDetailDTO) -> MovieDetail? {
        guard let id = dto.id else { return nil }
        let title = dto.title ?? dto.originalTitle ?? "Untitled"
        let posterURL = APIConstants.tmdbImageURL(path: dto.posterPath, size: APIConstants.posterSizeDetail)
        let backdropURL = APIConstants.tmdbImageURL(path: dto.backdropPath, size: APIConstants.backdropSizeDetail)

        let year: String? = {
            guard let releaseDate = dto.releaseDate, releaseDate.count >= 4 else { return nil }
            return String(releaseDate.prefix(4))
        }()

        let genres = (dto.genres ?? []).compactMap(\.name)
        let languages = (dto.spokenLanguages ?? []).compactMap { $0.name ?? $0.englishName }

        return MovieDetail(
            id: id,
            title: title,
            posterURL: posterURL,
            backdropURL: backdropURL,
            year: year,
            genres: genres,
            overview: dto.overview ?? "",
            homepage: dto.homepage,
            budget: dto.budget ?? 0,
            revenue: dto.revenue ?? 0,
            spokenLanguages: languages,
            status: dto.status ?? "",
            runtime: dto.runtime
        )
    }
}
