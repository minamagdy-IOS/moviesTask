//
//  MovieDetail.swift
//  Movies
//
//  Created by Mina Magdy on 02/04/2026.
//

import Foundation

struct MovieDetail: Identifiable {
    let id: Int
    let title: String
    let posterURL: URL?
    let backdropURL: URL?
    let year: String?
    let genres: [String]
    let overview: String
    let homepage: String?
    let budget: Int
    let revenue: Int
    let spokenLanguages: [String]
    let status: String
    /// Runtime in minutes. `nil` means unknown.
    let runtime: Int?
}
