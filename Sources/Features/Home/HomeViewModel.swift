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
    
    var filteredRepositories: [Repository] {
        repositories.filter {
            searchText.isEmpty
            || $0.name.contains(searchText)
        }
    }
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var uiState: RepositoryUIState = RepositoryUIState()
    
    func search() {
        //TODO: Repositoryデータの取得をする関数の呼び出し
    }
    
    func changeSearchText(_ searchText: String) {
        uiState.searchText = searchText
    }
}
