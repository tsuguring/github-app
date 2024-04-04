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
    package static var sampleData = Repository(id: 1296269, name: "MDEwOlJlcG9zaXRvcnkxMjk2MjY5", fullName: "Hello-World", owner: User(id: 1, name: "octocat", avatarImagePath: "https://github.com/images/error/octocat_happy.gif", htmlPath: "https://github.com/octocat"), starsCount: 80, watchersCount: 80, forksCount: 9, openIssuesCount: 0, language: nil, htmlPath: "https://github.com/octocat/Hello-World", websitePath: "https://github.com", description: "This your first repo!")
}
