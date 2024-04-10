//
//  HomeView.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/01.
//

import SwiftUI

package struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    package var body: some View {
        RepositoryListView()
            .searchable(text: .init(get: { viewModel.uiState.searchText
            }, set: { newValue in
                viewModel.changeSearchText(newValue)
            }))
    }
    
    package init() {}
}
