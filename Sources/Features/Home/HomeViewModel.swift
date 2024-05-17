//
//  HomeViewModel.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/01.
//

import Foundation
import GitHubData
import UICore

struct RepositoryUIState {
    var repositories: Stateful<[Repository]> = .idle
    var searchText: String = ""
}

enum HomeAction {
    case onSearchTextChange(searchText: String)}

enum HomeActionAsync {
    case onRepositoriesSearch
    case onPullToRefresh
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var uiState: RepositoryUIState = RepositoryUIState()
    private let repoRepository: RepoRepository
    
    init(repoRepository: some RepoRepository = RepoDefaultRepository()) {
        self.repoRepository = repoRepository
    }
    
    func send(_ action: HomeAction) {
        switch action {
        case .onSearchTextChange(let searchText):
            changeSearchText(searchText)
        }
    }
    
    func sendAsync(_ action: HomeActionAsync) async {
        switch action {
        case .onRepositoriesSearch:
            await searchRepositories()
        case .onPullToRefresh:
            await pullToRefresh()
        }
    }
}

// MARK: - Private Functions

private extension HomeViewModel {
    func changeSearchText(_ searchText: String) {
        uiState.searchText = searchText
    }
    
    func searchRepositories() async {
        uiState.repositories = .loading
        await fetchRepositories()
    }
    
    func pullToRefresh() async {
        await fetchRepositories()
    }
    
    func fetchRepositories() async {
        do {
            let repositories = try await self.repoRepository.searchRepository(keyword: uiState.searchText)
            uiState.repositories = .success(repositories)
        } catch {
            if Task.isCancelled {
                uiState.repositories = .idle
            }
            uiState.repositories = .failed(error)
        }
    }
}
