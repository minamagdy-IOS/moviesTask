//
//  APIConstants.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//


import Foundation

enum APIConstants {
    static let baseURL = "api.themoviedb.org"
    static let apiKey = "b0c5439b7e45bfa788fb745a5b6964f5"
    static let imageCDNBase = "https://image.tmdb.org/t/p/"
    static let posterSizeList = "w500"
    static let posterSizeDetail = "w500"
    static let backdropSizeDetail = "w1280"

    static func tmdbImageURL(path: String?, size: String) -> URL? {
        guard let path, path.hasPrefix("/") else { return nil }
        return URL(string: imageCDNBase + size + path)
    }
}
