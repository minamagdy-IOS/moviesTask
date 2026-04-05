//
//  MovieDetailDTO.swift
//  Movies
//
//  Created by Mina Magdy on 02/04/2026.
//

import Foundation

struct MovieDetailDTO: Codable {
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var homepage: String?
    var id: Int?
    var imdbID, originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var revenue, runtime: Int?
    var spokenLanguages: [SpokenLanguageDTO]?
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var genres: [GenreDTO]?
}

struct SpokenLanguageDTO: Codable {
    var englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
