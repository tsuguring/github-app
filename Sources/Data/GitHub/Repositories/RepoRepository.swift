//
//  RepoRepository.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/12.
//

import Foundation
import NetworkCore

package protocol RepoRepository {
    func searchRepository(keyword: String) async throws -> [Repository]
}

package final class RepoDefaultRepository: RepoRepository {
    package static let shared = RepoDefaultRepository()
    
    private let apiClient: APIClient
    
    package init(apiClient: APIClient = APIClient()) {
        self.apiClient = APIClient()
    }
    
    package func searchRepository(keyword: String) async throws -> [Repository] {
        let request = RepositoryRequest(keyword: keyword)
        let response = try await apiClient.request(with: request)
        return response.items
    }
}

private struct RepositoryRequest: BaseRequestProtocol {
    typealias ResponseType = SearchResponse<Repository>
    
    var baseURL: URL = URL(string: "https://api.github.com")!
    var httpMethod: HTTPMethod = .get
    var path: String = "/search/repositories"
    var body: String = ""
    var keyword: String
    
    init(keyword: String) {
        self.keyword = keyword
    }
    
    var queryItem: [URLQueryItem] {
        [URLQueryItem(name: "q", value: self.keyword)]
    }
}
