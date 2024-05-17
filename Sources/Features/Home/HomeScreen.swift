//
//  HomeView.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import SwiftUI

package struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModel()
    package var body: some View {
        RepositoryListView(viewModel: viewModel)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: .init(get: { viewModel.uiState.searchText }, set: { newValue in
                viewModel.send(.onSearchTextChange(searchText: newValue))
            }), placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                Task { await viewModel.sendAsync(.onRepositoriesSearch) }
            }
    }
    
    package init() {}
}

#if DEBUG
#Preview {
    HomeScreen()
}
#endif
