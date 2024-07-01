//
//  Stateful.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/28.
//

import Foundation

package enum Stateful<Value: Equatable>: Equatable {
    case idle
    case loading
    case success(Value)
    case failed(Error)
    
    public static func == (lhs: Stateful<Value>, rhs: Stateful<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.success(let lhsValue), .success(let rhsValue)):
            return lhsValue == rhsValue
        case (.failed(let lhsError), .failed(let rhsError)):
            return (lhsError as NSError).domain == (rhsError as NSError).domain &&
            (lhsError as NSError).code == (rhsError as NSError).code
        default:
            return false
        }
    }
}
