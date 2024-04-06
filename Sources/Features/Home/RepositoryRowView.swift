//
//  RepositoryLowView.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/04/03.
//

import SwiftUI
import GitHubData

struct RepositoryRowView: View {
    let sampleRepositoryData = Repository.sampleData
    var body: some View {
        VStack {
            ownerImage
            Text(sampleRepositoryData.fullName)
            Text(sampleRepositoryData.description ?? "")
        }
    }
}

private extension RepositoryRowView {
    var imageURL: URL? {
        URL(string: sampleRepositoryData.owner.avatarImagePath)
    }
    
    var ownerImage: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 30, height: 30)
    }
    
}
