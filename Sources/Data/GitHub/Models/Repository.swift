//
//  Repository.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import Foundation

package struct Repository: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case starsCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case language
        case htmlPath = "html_url"
        case websitePath = "homepage"
        case description
    }
    
    let id: Int
    let name: String
    let fullName: String
    let owner: User
    let starsCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let language: String?
    let htmlPath: String
    let websitePath: String?
    let description: String?
}
