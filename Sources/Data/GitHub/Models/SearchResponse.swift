//
//  SearchResponse.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/18.
//

import Foundation

package struct SearchResponse<Item: Decodable>: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    package let totalCount: Int
    package let items: [Item]
}
