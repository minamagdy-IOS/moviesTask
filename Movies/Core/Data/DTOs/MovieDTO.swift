//
//  MovieDTO.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

struct MovieDTO: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath, releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
}
