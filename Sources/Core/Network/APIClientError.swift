//
//  APIClientError.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/11.
//

import Foundation

package enum APIClientError: Error {
    case connectionError
    case apiError
    case parseError
    
    package var message: String {
        switch self {
        case .apiError:
            return "サーバーからのエラーが発生しました"
        case .connectionError:
            return "サーバーと接続できませんでした"
        case .parseError:
            return "データの取得に失敗しました"
        }
    }
}
