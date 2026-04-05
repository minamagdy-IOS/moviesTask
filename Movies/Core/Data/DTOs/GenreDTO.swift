//
//  GenreDTO.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

struct GenreDTO: Codable {
    var id: Int?
    var name: String?
}

struct GenreListResponseDTO: Codable {
    let genres: [GenreDTO]?
}
