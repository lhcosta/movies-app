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
    private let service: ImageServicing
    
    init(
        url: URL?,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content,
        service: ImageServicing = ImageService()
    ) {
        self.url = url
        self.content = content
        self.service = service
    }
    
    var body: some View {
        if let image = try? service.fetch(url: url) {
            content(.success(image))
        } else {
            AsyncImage(url: url) { result in
                if case .success(let image) = result {
                    content(.success(image))
                        .task {
                            service.save(
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
