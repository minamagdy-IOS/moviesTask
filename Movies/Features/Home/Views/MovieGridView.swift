//
//  MovieGridView.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import SwiftUI

struct MovieGridView: View {
    let movies: [Movie]
    let onItemAppear: (Movie) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(movies) { movie in
                NavigationLink(value: movie) {
                    MoviePosterCell(movie: movie)
                }
                .buttonStyle(.plain)
                .onAppear {
                    onItemAppear(movie)
                }
            }
        }
    }
}

private struct MoviePosterCell: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            poster
                .aspectRatio(2 / 3, contentMode: .fill)
                .clipped()
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.name)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                if let year = movie.releaseYear {
                    Text(year)
                        .font(.caption)
                        .foregroundStyle(AppTheme.secondaryText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 8)
            .padding(.horizontal, 2)
        }
    }

    @ViewBuilder
    private var poster: some View {
        if let url = movie.posterURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        ZStack {
            Color.gray.opacity(0.25)
            Image(systemName: "film")
                .font(.largeTitle)
                .foregroundStyle(AppTheme.secondaryText)
        }
    }
}
