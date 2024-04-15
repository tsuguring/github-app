//
//  BaseRequestProtocol.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/11.
//

import Foundation

package protocol BaseRequestProtocol {
    associatedtype ResponseType: Decodable
    
    var baseURL: URL { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var body: String { get }
    var queryItem: [URLQueryItem] { get }
    
    func buildURLRequest() -> URLRequest
}

extension BaseRequestProtocol {
    package func buildURLRequest() -> URLRequest {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = path
        
        switch httpMethod {
        case .get:
            urlComponents?.queryItems = queryItem
        default:
            fatalError()
        }
        
        guard let url = urlComponents?.url else {
            fatalError()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body.data(using: .utf8)
        
        return urlRequest
    }
}
