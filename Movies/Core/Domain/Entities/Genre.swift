//
//  Genre.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

struct Genre: Identifiable, Equatable {
    /// `-1` represents "All genres" in the UI.
    let id: Int
    let tmdbId: Int?
    let name: String?

    static let allGenresId = -1

    init(tmdbId: Int?, name: String?) {
        self.tmdbId = tmdbId
        self.id = tmdbId ?? Self.allGenresId
        self.name = name
    }
}

extension Genre: Codable {
    enum CodingKeys: String, CodingKey {
        case tmdbId
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tid = try container.decodeIfPresent(Int.self, forKey: .tmdbId)
        let n = try container.decodeIfPresent(String.self, forKey: .name)
        self.init(tmdbId: tid, name: n)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(tmdbId, forKey: .tmdbId)
        try container.encodeIfPresent(name, forKey: .name)
    }
}
