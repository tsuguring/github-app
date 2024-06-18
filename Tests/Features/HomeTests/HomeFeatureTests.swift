//
//  HomeFeatureTests.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/06/14.
//

import XCTest
@testable import HomeFeature
@testable import NetworkCore

struct MockGitHubAPIClient: APIClientProtocol {
    var result: Result<Data, Error>?
    
    func request<Request: BaseRequestProtocol>(with request: Request) async throws -> Request.ResponseType {
        switch result {
        case .success(let data):
            return try JSONDecoder().decode(Request.ResponseType, from: data)
        }
    }
}

final class HomeFeatureTests: XCTestCase {
    func testSearch...t () throws {
        
    }
}
