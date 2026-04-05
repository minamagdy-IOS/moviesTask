//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Mina Magdy on 02/04/2026.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    let movieId: Int
    private let useCase: any GetMovieDetailsUC

    @Published private(set) var movieDetail: MovieDetail?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    init(movieId: Int, useCase: any GetMovieDetailsUC) {
        self.movieId = movieId
        self.useCase = useCase
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        let result = await useCase.execute(movieId: movieId)
        isLoading = false
        switch result {
        case .success(let detail):
            movieDetail = detail
        case .failure:
            errorMessage = "Could not load movie details."
        }
    }

    // MARK: - Formatted display values

    var genresDisplay: String {
        guard let genres = movieDetail?.genres, !genres.isEmpty else { return "—" }
        return genres.joined(separator: ", ")
    }

    var languagesDisplay: String {
        guard let languages = movieDetail?.spokenLanguages, !languages.isEmpty else { return "—" }
        return languages.joined(separator: ", ")
    }

    var budgetDisplay: String { format(currency: movieDetail?.budget ?? 0) }
    var revenueDisplay: String { format(currency: movieDetail?.revenue ?? 0) }

    var runtimeDisplay: String {
        guard let runtime = movieDetail?.runtime, runtime > 0 else { return "—" }
        return "\(runtime) minutes"
    }

    var statusDisplay: String {
        let s = movieDetail?.status ?? ""
        return s.isEmpty ? "—" : s
    }

    // MARK: - Private

    private static let currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "en_US")
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return f
    }()

    private func format(currency amount: Int) -> String {
        guard amount > 0 else { return "—" }
        let number = Self.currencyFormatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return "\(number) $"
    }
}
