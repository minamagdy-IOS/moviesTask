//
//  MovieListDiskCache.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//


import CryptoKit
import Foundation

protocol MovieListDiskCaching: Sendable {
    func saveMoviesPage(_ result: PaginatedMoviesResult, key: String) async throws
    func loadMoviesPage(key: String) async throws -> PaginatedMoviesResult?
    func saveGenres(_ genres: [Genre]) async throws
    func loadGenres() async throws -> [Genre]?
}

actor MovieListDiskCache: MovieListDiskCaching {
    private let moviesDirectory: URL
    private let genresFile: URL
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(fileManager: FileManager = .default) {
        let base = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
            ?? fileManager.temporaryDirectory
        moviesDirectory = base.appendingPathComponent("MoviesCache/Pages", isDirectory: true)
        genresFile = base.appendingPathComponent("MoviesCache/genres.json", isDirectory: false)
        try? fileManager.createDirectory(at: moviesDirectory, withIntermediateDirectories: true)
    }

    func saveMoviesPage(_ result: PaginatedMoviesResult, key: String) async throws {
        let url = moviesDirectory.appendingPathComponent(Self.fileName(prefix: "m", key: key))
        try encoder.encode(result).write(to: url, options: .atomic)
    }

    func loadMoviesPage(key: String) async throws -> PaginatedMoviesResult? {
        let url = moviesDirectory.appendingPathComponent(Self.fileName(prefix: "m", key: key))
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        return try decoder.decode(PaginatedMoviesResult.self, from: Data(contentsOf: url))
    }

    func saveGenres(_ genres: [Genre]) async throws {
        try encoder.encode(genres).write(to: genresFile, options: .atomic)
    }

    func loadGenres() async throws -> [Genre]? {
        guard FileManager.default.fileExists(atPath: genresFile.path) else { return nil }
        return try decoder.decode([Genre].self, from: Data(contentsOf: genresFile))
    }

    private static func fileName(prefix: String, key: String) -> String {
        let digest = SHA256.hash(data: Data(key.utf8))
        let hex = digest.map { String(format: "%02x", $0) }.joined()
        return "\(prefix)_\(hex).json"
    }
}

enum MovieListDiskCacheFactory {
    static func makeDefault() -> MovieListDiskCaching {
        MovieListDiskCache()
    }
}
