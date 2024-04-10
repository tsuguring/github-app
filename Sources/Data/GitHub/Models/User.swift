//
//  File.swift
//  
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import Foundation

package struct User: Codable {
    
    package enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarImagePath = "avatar_url"
        case htmlPath = "html_url"
    }
    
    package var id: Int
    package var name: String
    package var avatarImagePath: String
    package var htmlPath: String
    
    package var avatarImageURL: URL? {
        URL(string: avatarImagePath)
    }
    package var htmlURL: URL? {
        URL(string: htmlPath)
    }
}
