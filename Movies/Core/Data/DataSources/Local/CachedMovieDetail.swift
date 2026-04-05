//
//  CachedMovieDetail.swift
//  Movies
//
//  Created by Mina Magdy on 02/04/2026.
//


import Foundation
import SwiftData

@Model
final class CachedMovieDetail: @unchecked Sendable {
    @Attribute(.unique) var tmdbId: Int
    var title: String
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String?
    var runtime: Int?
    var voteAverage: Double?
    var voteCount: Int?
    var genreIds: [Int]
    var lastUpdated: Date

    var isExpired: Bool {
        Date.now.timeIntervalSince(lastUpdated) > 86_400
    }

    init(
        tmdbId: Int,
        title: String,
        originalTitle: String? = nil,
        overview: String? = nil,
        posterPath: String? = nil,
        backdropPath: String? = nil,
        releaseDate: String? = nil,
        runtime: Int? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        genreIds: [Int] = [],
        lastUpdated: Date = .now
    ) {
        self.tmdbId = tmdbId
        self.title = title
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.genreIds = genreIds
        self.lastUpdated = lastUpdated
    }
}
