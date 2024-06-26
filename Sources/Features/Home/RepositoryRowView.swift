//
//  RepositoryLowView.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import SwiftUI
import GitHubData

struct RepositoryRowView: View {
    let repository: Repository
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ownerImage
                Text(repository.owner.name)
            }
            title
            description
            HStack {
                starCount
                language
            }
        }
    }
}

private extension RepositoryRowView {
    var imageURL: URL? {
        URL(string: repository.owner.avatarImagePath)
    }
    
    var ownerImage: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 25, height: 25)
    }
    
    var title: some View {
        Text(repository.fullName)
            .bold()
            .font(.system(size: 20))
            .padding(.vertical, 1)
    }
    
    @ViewBuilder var description: some View {
        if let description = repository.description {
            Text(description).padding(.bottom, 1)
        }
    }
    
    var starCount: some View {
        HStack(spacing: 0) {
            Image(systemName: "star")
            Text(String(repository.starsCount))
        }
    }
    
    @ViewBuilder var language: some View {
        if let language = repository.language {
            HStack(spacing: 0) {
                Image(systemName: "text.word.spacing")
                Text(language)
            }.padding(.leading, 20)
        }
    }
}
