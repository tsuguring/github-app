//
//  APIClientError.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/11.
//

import Foundation

enum APIClientError: Error {
    case connectionError(Data)
    case apiError
}
