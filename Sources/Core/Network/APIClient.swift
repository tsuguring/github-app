//
//  APIClient.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/11.
//

import Foundation

protocol APIClientProtocol {
    func request<Request: BaseRequestProtocol>(with request: Request) async throws -> Request.ResponseType
}

package struct APIClient: APIClientProtocol {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    package func request<Request: BaseRequestProtocol>(with request: Request) async throws -> Request.ResponseType {
        let result: (Data, URLResponse)
        
        do {
            result = try await session.data(for: request.buildURLRequest())
        } catch {
            throw APIClientError.connectionError
        }
        
        try validate(data: result.0, response: result.1)
        return try JSONDecoder().decode(Request.ResponseType.self, from: result.0)
    }
    
    private func validate(data: Data, response: URLResponse) throws {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIClientError.connectionError
        }
        
        guard (200..<300).contains(code) else {
            throw APIClientError.apiError
        }
    }
     
     package init () {}
}
