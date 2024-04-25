//
//  RepositoryListView.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import SwiftUI
import GitHubData

struct RepositoryListView: View {
    let repositories: [Repository]
    var body: some View {
        List{
            ForEach(repositories) { repository in
                RepositoryRowView(repository: repository)
            }
        }
    }
}
