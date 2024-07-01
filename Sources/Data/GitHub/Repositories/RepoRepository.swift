//
//  RepoRepository.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/12.
//

import Foundation
import NetworkCore

package protocol RepoRepository {
    func searchRepository(keyword: String, page: Int) async throws -> SearchResponse<Repository>
}

package final class RepoDefaultRepository: RepoRepository {
    package static let shared = RepoDefaultRepository()
    
    private let apiClient: APIClientProtocol
    
    package init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    package func searchRepository(keyword: String, page: Int) async throws -> SearchResponse<Repository> {
        let request = RepositoryRequest(keyword: keyword, page: page)
        try await Task.sleep(nanoseconds: 500_000_000) // インジケーターを表示させるため、0.5秒の停止させる
        let response = try await apiClient.request(with: request)
        return response
    }
}

private struct RepositoryRequest: BaseRequestProtocol {
    typealias ResponseType = SearchResponse<Repository>
    
    var baseURL: URL = URL(string: "https://api.github.com")!
    var httpMethod: HTTPMethod = .get
    var path: String = "/search/repositories"
    var body: String = ""
    var keyword: String
    var page: Int
    
    init(keyword: String, page: Int) {
        self.keyword = keyword
        self.page = page
    }
    
    var queryItem: [URLQueryItem] {
        [URLQueryItem(name: "q", value: self.keyword), URLQueryItem(name: "page", value: String(self.page))]
    }
}
