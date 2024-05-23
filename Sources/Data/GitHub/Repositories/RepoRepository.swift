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
    
    private let apiClient: APIClient
    
    package init(apiClient: APIClient = APIClient()) {
        self.apiClient = APIClient()
    }
    
    package func searchRepository(keyword: String, page: Int) async throws -> SearchResponse<Repository> {
        let request = RepositoryRequest(keyword: keyword, page: page)
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
