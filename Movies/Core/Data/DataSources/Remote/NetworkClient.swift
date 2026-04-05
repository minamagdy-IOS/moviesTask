//
//  NetworkClient.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//


import Foundation

protocol NetworkClientProtocol: Sendable {
    func fetchData(for request: URLRequest) async throws -> Data
}

struct NetworkClient: NetworkClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData(for request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200 ... 299).contains(http.statusCode) else {
            throw NetworkError.httpStatus(http.statusCode)
        }
        return data
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpStatus(Int)
    case decodingFailed
    case missingAPIKey
}
