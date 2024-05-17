//
//  RepositoryListView.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import SwiftUI
import GitHubData
import NetworkCore

struct RepositoryListView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        switch viewModel.uiState.repositories {
        case .idle:
            Ready
        case .loading:
            Loading
        case .success(let repositories):
            RepositoryList(repositories)
        case .failed(let error):
            Error(error)
        }
    }
}

private extension RepositoryListView {
    var Ready: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 70, height: 70)
            Text("検索しましょう")
                .font(.system(size:20))
                .bold()
                .padding(.bottom, 10)
            Text("GitHubのリポジトリを検索できます")
        }
    }
    
    var Loading: some View {
        VStack {
            ProgressView()
            Text("検索中...")
        }
    }
    
    func RepositoryList(_ repositories: [Repository]) -> some View {
        List{
            ForEach(repositories) { repository in
                RepositoryRowView(repository: repository)
            }
        }
        .refreshable {
            await viewModel.sendAsync(.onPullToRefresh)
        }
    }
    
    func Error(_ error: Error) -> some View {
        // ScrollView内のViewを中央揃えにするためGeometryReaderを使用
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                    Text("リポジトリが取得できませんでした")
                        .font(.system(size:20))
                        .bold()
                        .padding(.bottom, 10)
                    if let fetchError = error as? APIClientError {
                        switch fetchError {
                        case .apiError:
                            Text(fetchError.message)
                        case .connectionError:
                            Text(fetchError.message)
                        case .parseError:
                            Text(fetchError.message)
                        }
                    } else {
                        Text(error.localizedDescription)
                    }
                }
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height)
            }
            .refreshable {
                await viewModel.sendAsync(.onPullToRefresh)
            }
        }
    }
}
