//
//  Movie.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

struct Movie: Identifiable, Equatable, Hashable, Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let releaseYear: String?
    let posterURL: URL?
}
