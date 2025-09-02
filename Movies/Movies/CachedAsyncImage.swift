//
//  CachedAsyncImage.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    private let url: URL?
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: URL?,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.content = content
    }
    
    var body: some View {
        if let image = try? ImageService.shared.fetch(url: url) {
            content(.success(image))
        } else {
            AsyncImage(url: url) { result in
                if case .success(let image) = result {
                    content(.success(image))
                        .task {
                            ImageService.shared.save(
                                image: image,
                                at: url
                            )
                        }
                } else {
                    content(result)
                }
            }
        }
    }
}

#Preview {
    CachedAsyncImage(url: nil) { _ in }
}
