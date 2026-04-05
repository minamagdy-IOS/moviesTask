//
//  MovieDetailView.swift
//  Movies
//
//  Created by Mina Magdy on 02/04/2026.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var viewModel: MovieDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(movie: Movie) {
        self.movie = movie
        Resolver.bootstrapIfNeeded()
        _viewModel = StateObject(
            wrappedValue: MovieDetailViewModel(
                movieId: movie.id,
                useCase: Resolver.shared.resolve((any GetMovieDetailsUC).self)
            )
        )
    }

    var body: some View {
        ZStack {
            if let movieDetail = viewModel.movieDetail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        MovieDetailsHeaderView(
                            backdropURL: movieDetail.backdropURL,
                            onBackTapped: { dismiss() }
                        )
                        MovieDetailsContentView(movieDetail: movieDetail, viewModel: viewModel)
                    }
                }
            } else if viewModel.isLoading {
                ProgressView()
                    .tint(AppTheme.accentYellow)
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.white)
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .task {
            await viewModel.load()
        }
    }
}

private struct MovieDetailsContentView: View {
    let movieDetail: MovieDetail
    let viewModel: MovieDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MovieHeaderSection(
                posterURL: movieDetail.posterURL,
                title: movieDetail.title,
                genres: viewModel.genresDisplay
            )
            MovieOverviewSection(overview: movieDetail.overview)
            MovieInfoSection(
                homepage: movieDetail.homepage,
                languages: viewModel.languagesDisplay,
                status: viewModel.statusDisplay,
                runtime: viewModel.runtimeDisplay,
                budget: viewModel.budgetDisplay,
                revenue: viewModel.revenueDisplay
            )
        }
    }
}

private struct MovieHeaderSection: View {
    let posterURL: URL?
    let title: String
    let genres: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            PosterImageView(posterURL: posterURL)
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(genres)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

private struct PosterImageView: View {
    let posterURL: URL?

    var body: some View {
        Group {
            if let url = posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty: placeholder
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure: placeholder
                    @unknown default: placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: 100, height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var placeholder: some View {
        ZStack {
            Color.gray.opacity(0.3)
            Image(systemName: "film").foregroundStyle(AppTheme.secondaryText)
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(
            movie: Movie(id: 1, name: "Sample", posterPath: nil, releaseYear: "2021", posterURL: nil)
        )
    }
}
