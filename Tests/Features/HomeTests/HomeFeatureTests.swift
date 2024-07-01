//
//  HomeFeatureTests.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/06/14.
//

import XCTest
@testable import HomeFeature
@testable import GitHubData
@testable import NetworkCore
@testable import UICore

struct MockGitHubAPIClient: APIClientProtocol {
    var result: Result<(Data, URLResponse), Error>?
    
    func request<Request: BaseRequestProtocol>(with request: Request) async throws -> Request.ResponseType {
        switch result {
        case .success(let result):
            try validate(data: result.0, response: result.1)
            return try JSONDecoder().decode(Request.ResponseType.self, from: result.0)
        case .failure:
            throw APIClientError.connectionError
        case .none:
            throw APIClientError.connectionError
        }
    }
    
    private func validate(data: Data, response: URLResponse) throws {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIClientError.connectionError
        }
        
        guard (200..<300).contains(code) else {
            throw APIClientError.apiError
        }
    }
}


final class HomeFeatureTests: XCTestCase {
    
    @MainActor func test_リポジトリ検索が成功した場合UIStateが更新される() async throws {
        guard let successData = getSuccessData() else {
            return
        }
        
        let mockAPIClient = MockGitHubAPIClient(result: .success(successData))
        let repoRepository = RepoDefaultRepository(apiClient: mockAPIClient)
        let viewModel = HomeViewModel(repoRepository: repoRepository)
        
        viewModel.send(.onSearchTextChange(searchText: "Tetris"))
        await viewModel.sendAsync(.onRepositoriesSearch)
        
        let repositories: [Repository] = [
            Repository(
                id: 3081286,
                name: "Tetris",
                fullName: "dtrupenn/Tetris",
                owner: User(id: 872147, name: "dtrupenn", avatarImagePath: "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png", htmlPath: "https://github.com/octocat"),
                starsCount: 1,
                watchersCount: 1,
                forksCount: 0,
                openIssuesCount: 0,
                language: "Assembly",
                htmlPath: "https://github.com/dtrupenn/Tetris",
                websitePath: "https://github.com",
                description: "A C implementation of Tetris using Pennsim through LC4"
            )
        ]
        let expectedUiState: RepositoryUIState = RepositoryUIState(repositories: .success(repositories), searchText: "Tetris", currentPage: 1, totalRepositoriesCount: 40)
        XCTAssertEqual(viewModel.uiState, expectedUiState)
    }
    
    @MainActor func test_リポジトリ検索が失敗した場合UIStateが更新される() async throws {
        let mockAPIClient = MockGitHubAPIClient(result: .failure(APIClientError.connectionError))
        let repoRepository = RepoDefaultRepository(apiClient: mockAPIClient)
        let viewModel = HomeViewModel(repoRepository: repoRepository)
        
        viewModel.send(.onSearchTextChange(searchText: "Tetris"))
        await viewModel.sendAsync(.onRepositoriesSearch)
    
        let expectedUiState: RepositoryUIState = RepositoryUIState(repositories: .failed(APIClientError.connectionError), searchText: "Tetris")
        XCTAssertEqual(viewModel.uiState, expectedUiState)
    }
    
    private func getSuccessData() -> (Data, URLResponse)? {
        guard let fileUrl = Bundle.module.url(forResource: "SearchRepositoriesTestData", withExtension: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: fileUrl) else {
            return nil
        }
        
        let urlResponse = HTTPURLResponse(
            url: URL(string: "https://api.github.com/search/repositories")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        return (data, urlResponse)
    }
}
