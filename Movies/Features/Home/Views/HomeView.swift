//
//  HomeView.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var selectedCategory = 0

    @Environment(\.modelContext) private var modelContext
    @Query private var userPreferences: [UserPreferences]

    init() {
        Resolver.bootstrapIfNeeded()
        _viewModel = StateObject(wrappedValue: Resolver.shared.resolve(HomeViewModel.self))
    }

    private var preferences: UserPreferences {
        userPreferences.first ?? {
            let prefs = UserPreferences()
            modelContext.insert(prefs)
            try? modelContext.save()
            return prefs
        }()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    connectivityBanner

                    SearchBarView(text: $viewModel.searchText, prompt: "Search TMDB")

                    SectionHeaderView(title: "Watch New Movies")

                    CategoryView(
                        categories: viewModel.genre,
                        selected: $selectedCategory
                    )
                    .onChange(of: selectedCategory) { _, newIndex in
                        preferences.lastSelectedGenreIndex = newIndex
                        try? modelContext.save()
                        Task {
                            await viewModel.loadMovies(
                                from: 1,
                                genreOverride: viewModel.genreIdString(at: newIndex)
                            )
                        }
                    }
                    .onAppear {
                        selectedCategory = preferences.lastSelectedGenreIndex
                    }

                    MovieGridView(
                        movies: viewModel.movies,
                        onItemAppear: { movie in
                            Task { await viewModel.loadMoreMoviesIfNeeded(currentItem: movie) }
                        }
                    )
                }
                .padding(.horizontal, 15)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationBarHidden(true)
            .onChange(of: viewModel.debouncedSearchText) { _, newValue in
                if !newValue.isEmpty {
                    preferences.addSearchTerm(newValue)
                    try? modelContext.save()
                }
                Task { await viewModel.searchMovies() }
            }
            .refreshable { await viewModel.loadMovies(from: 1) }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
        .tint(AppTheme.accentYellow)
    }

    @ViewBuilder
    private var connectivityBanner: some View {
        if !viewModel.isOnline {
            HStack(spacing: 8) {
                Image(systemName: "wifi.slash")
                    .font(.subheadline.weight(.semibold))
                Text("Offline — showing cached movies when available.")
                    .font(.subheadline.weight(.medium))
            }
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(AppTheme.accentYellow.opacity(0.95))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [CachedMovieDetail.self, UserPreferences.self], inMemory: true)
}
