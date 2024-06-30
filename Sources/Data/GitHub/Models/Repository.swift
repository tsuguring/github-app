//
//  Repository.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import Foundation

package struct Repository: Codable, Identifiable, Equatable {
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
    
    package let id: Int
    package let name: String
    package let fullName: String
    package let owner: User
    package let starsCount: Int
    package let watchersCount: Int
    package let forksCount: Int
    package let openIssuesCount: Int
    package let language: String?
    package let htmlPath: String
    package let websitePath: String?
    package let description: String?
}

extension Repository {
    package static var sampleData = Repository(id: 609430492, name: "R_kgDOJFMr3A", fullName: "vbt-watch", owner: User(id: 52564598, name: "tsuguring", avatarImagePath: "https://avatars.githubusercontent.com/u/52564598?v=4", htmlPath: "https://github.com/tsuguring"), starsCount: 0, watchersCount: 0, forksCount: 1, openIssuesCount: 0, language: "Swift", htmlPath: "https://github.com/tsuguring/vbt-watch", websitePath: "", description: "watchOS apps that support VBT") }
