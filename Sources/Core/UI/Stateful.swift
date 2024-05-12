//
//  Stateful.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/28.
//

import Foundation

package enum Stateful<Value> {
    case idle
    case loading
    case success(Value)
    case failed(Error)
}
