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

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var uiState: RepositoryUIState = RepositoryUIState()
    private let repoRepository: RepoRepository
    
    init(repoRepository: some RepoRepository = RepoDefaultRepository()) {
        self.repoRepository = repoRepository
    }
    
    func changeSearchText(_ searchText: String) {
        uiState.searchText = searchText
    }
    
    func searchRepositories() async {
        uiState.repositories = .loading
        Task {
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
}
