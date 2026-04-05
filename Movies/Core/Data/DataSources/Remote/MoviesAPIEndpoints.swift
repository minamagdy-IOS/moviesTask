//
//  MoviesAPIEndpoints.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//


import Foundation

enum MoviesAPIEndpoints {
    private static func makeURL(path: String, queryItems: [URLQueryItem]) throws -> URL {
        guard !APIConstants.apiKey.isEmpty else {
            throw NetworkError.missingAPIKey
        }
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.baseURL
        components.path = path
        var items = queryItems
        items.insert(URLQueryItem(name: "api_key", value: APIConstants.apiKey), at: 0)
        components.queryItems = items
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        return url
    }

    static func discoverMovies(page: Int, withGenreId: String?) throws -> URL {
        var query: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]
        if let genreId = withGenreId, !genreId.isEmpty {
            query.append(URLQueryItem(name: "with_genres", value: genreId))
        }
        return try makeURL(path: "/3/discover/movie", queryItems: query)
    }

    static func searchMovies(query: String, page: Int) throws -> URL {
        let items: [URLQueryItem] = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return try makeURL(path: "/3/search/movie", queryItems: items)
    }

    static func movieGenres() throws -> URL {
        try makeURL(path: "/3/genre/movie/list", queryItems: [])
    }

    static func movieDetail(movieId: Int) throws -> URL {
        try makeURL(path: "/3/movie/\(movieId)", queryItems: [])
    }
}
