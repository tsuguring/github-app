//
//  HomeViewModel.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/01.
//

import GitHubData
import Foundation

struct RepositoryUIState {
    var repositories: [Repository] = []
    var searchText: String = ""
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var uiState: RepositoryUIState = RepositoryUIState()
    private let repository: RepoRepository
    
    init(repository: some RepoRepository = RepoDefaultRepository()) {
        self.repository = repository
    }
    
    func changeSearchText(_ searchText: String) {
        uiState.searchText = searchText
    }
    
    func searchRepositories() async throws {
        uiState.repositories = try await self.repository.searchRepository(keyword: uiState.searchText)
    }
}
