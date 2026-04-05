//
//  PaginatedResponseDTO.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

struct PaginatedResponseDTO<T: Codable>: Codable {
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
    let results: [T]?
}
