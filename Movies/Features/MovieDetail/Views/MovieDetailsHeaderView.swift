//
//  MovieDetailsHeaderView.swift
//  Movies
//
//  Created by Mina Magdy on 03/04/2026.
//

import SwiftUI

struct MovieDetailsHeaderView: View {
    let backdropURL: URL?
    let onBackTapped: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            BackdropImageView(backdropURL: backdropURL)
            HeaderButtonsView(onBackTapped: onBackTapped)
        }
    }
}

private struct BackdropImageView: View {
    let backdropURL: URL?

    var body: some View {
        Group {
            if let url = backdropURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        placeholderBackdrop
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        placeholderBackdrop
                    @unknown default:
                        placeholderBackdrop
                    }
                }
            } else {
                placeholderBackdrop
            }
        }
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .clipped()
    }

    private var placeholderBackdrop: some View {
        ZStack {
            Color.gray.opacity(0.3)
            Image(systemName: "film")
                .font(.largeTitle)
                .foregroundStyle(AppTheme.secondaryText)
        }
    }
}

private struct HeaderButtonsView: View {
    let onBackTapped: () -> Void

    var body: some View {
        HStack {
            CircleButton(icon: "chevron.left", action: onBackTapped)
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 4)
        .safeAreaPadding(.top, 50)
    }
}

private struct CircleButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
                .padding(10)
                .background(Color.black.opacity(0.35))
                .clipShape(Circle())
        }
    }
}
