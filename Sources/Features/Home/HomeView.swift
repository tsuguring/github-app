//
//  HomeView.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import SwiftUI

package struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    package var body: some View {
        RepositoryListView(repositories: viewModel.uiState.repositories)
            .searchable(text: .init(get: { viewModel.uiState.searchText }, set: { newValue in
                viewModel.changeSearchText(newValue)
            }))
            .onSubmit(of: .search) {
                Task {
                    try await viewModel.searchRepositories()
                }
            }
    }
    
    package init() {}
}

#if DEBUG
#Preview {
    HomeView()
}
#endif
