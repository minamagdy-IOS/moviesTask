//
//  HomeViewModel.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    private let getMoviesUseCase: any GetMoviesUC
    private let getGenresUseCase: any GetGenresUC
    private let reachability: any ConnectivityStatusProviding

    private var currentPage = 1
    private var totalPages = 1
    private var isLoadingPage = false
    private var hasMorePages = true
    private let debounceTime: Int

    @Published var movies: [Movie] = []
    @Published var genre: [Genre] = []
    @Published var searchText = ""
    @Published var debouncedSearchText = ""
    @Published private(set) var isOnline = true

    private(set) var selectedGenre = ""

    init(
        getMoviesUseCase: any GetMoviesUC,
        getGenresUseCase: any GetGenresUC,
        reachability: any ConnectivityStatusProviding,
        debounceTime: Int = 700
    ) {
        self.getMoviesUseCase = getMoviesUseCase
        self.getGenresUseCase = getGenresUseCase
        self.reachability = reachability
        self.debounceTime = debounceTime
        isOnline = reachability.isSatisfied()
        reachability.onChange = { [weak self] online in
            Task { @MainActor in
                guard let self else { return }
                let wasOffline = !self.isOnline
                self.isOnline = online
                if online, wasOffline {
                    await self.getGenre()
                    await self.loadMovies(from: 1)
                }
            }
        }
        setupSearchDebouncer()
        Task {
            await getGenre()
            await loadMovies(from: 1)
        }
    }

    private func setupSearchDebouncer() {
        $searchText
            .debounce(for: .milliseconds(debounceTime), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchText)
    }
}

extension HomeViewModel {
    func genreIdString(at index: Int) -> String {
        guard index >= 0, index < genre.count else { return "" }
        guard let tid = genre[index].tmdbId else { return "" }
        return "\(tid)"
    }

    func loadMovies(from page: Int = 1, genreOverride: String? = nil) async {
        if let override = genreOverride { selectedGenre = override }
        if page == 1 { hasMorePages = true }
        guard !isLoadingPage else { return }
        guard page == 1 || hasMorePages else { return }
        isLoadingPage = true
        defer { isLoadingPage = false }

        let result = await getMoviesUseCase.execute(
            with: GetMoviesParams(
                page: page,
                searchKey: debouncedSearchText.isEmpty ? nil : debouncedSearchText,
                genre: selectedGenre
            )
        )

        switch result {
        case .success(let data):
            if page == 1 {
                movies = data.movies
            } else {
                movies.append(contentsOf: data.movies)
            }
            currentPage = data.page ?? page
            totalPages = max(data.totalPages ?? 1, 1)
            hasMorePages = page < totalPages
        case .failure(let error):
            print(error)
        }
    }

    func searchMovies() async {
        await loadMovies(from: 1)
    }

    func loadMoreMoviesIfNeeded(currentItem: Movie) async {
        guard !isLoadingPage, hasMorePages else { return }
        guard movies.last?.id == currentItem.id else { return }
        let next = currentPage + 1
        guard next <= totalPages else {
            hasMorePages = false
            return
        }
        await loadMovies(from: next)
    }

    func getGenre() async {
        let result = await getGenresUseCase.execute()
        switch result {
        case .success(let genres):
            genre = genres
        case .failure(let error):
            print(error)
        }
    }
}
