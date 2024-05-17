//
//  DevelopRootScreen.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/03/26.
//

import SwiftUI
import HomeFeature

public struct DevelopRootScreen: View {
    public var body: some View {
        NavigationStack {
            HomeScreen()
        }
    }
    
    public init() {}
}

#if DEBUG
#Preview {
    DevelopRootScreen()
}
#endif
