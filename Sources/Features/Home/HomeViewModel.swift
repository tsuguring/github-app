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
    var currentPage: Int = 1
    var totalRepositoriesCount: Int = 0
    var canLoadNextPage: Bool {
        currentPage * 30 < totalRepositoriesCount
    }
}

enum HomeAction {
    case onSearchTextChange(searchText: String)
}

enum HomeActionAsync {
    case onRepositoriesSearch
    case onPullToRefresh
    case onNextPageFetch
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var uiState: RepositoryUIState = RepositoryUIState()
    private var currentTask: Task<Void, Never>?
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
        currentTask?.cancel() // 既存のタスクがあればキャンセル
        currentTask = Task {
            switch action {
            case .onRepositoriesSearch:
                await searchRepositories()
            case .onPullToRefresh:
                await pullToRefresh()
            case .onNextPageFetch:
                await fetchNextPage()
            }
        }
        await currentTask?.value // タスクが完了するまで待機
    }
}

// MARK: - Private Functions

private extension HomeViewModel {
    func changeSearchText(_ searchText: String) {
        uiState.searchText = searchText
    }
    
    func searchRepositories() async {
        uiState.repositories = .loading
        uiState.currentPage = 1
        await fetchRepositories()
    }
    
    func pullToRefresh() async {
        uiState.currentPage = 1
        await fetchRepositories()
    }
    
    func fetchNextPage() async {
        uiState.currentPage += 1
        do {
            let newRepositories = try await self.repoRepository.searchRepository(keyword: uiState.searchText, page: uiState.currentPage)
            if case .success(let existingRepositories) = uiState.repositories {
                uiState.repositories = .success(existingRepositories + newRepositories.items)
            }
        } catch {
            if Task.isCancelled {
                uiState.repositories = .idle
            } else {
                uiState.repositories = .failed(error)
            }
        }
    }
    
    func fetchRepositories() async {
        do {
            let repositories = try await self.repoRepository.searchRepository(keyword: uiState.searchText, page: uiState.currentPage)
            uiState.repositories = .success(repositories.items)
            uiState.totalRepositoriesCount = repositories.totalCount
        } catch {
            if Task.isCancelled {
                uiState.repositories = .idle
            }
            uiState.repositories = .failed(error)
        }
    }
}
