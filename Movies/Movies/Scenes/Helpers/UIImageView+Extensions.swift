//
//  File.swift
//  Movies
//
//  Created by Lucas Costa on 02/09/25.
//


import SwiftUI

extension UIImageView {
    func load(
        from url: URL?,
        service: ImageServicing = ImageService()
    ) {
        do {
            let image = try service.fetch(url: url)
            self.image = ImageRenderer(content: image).uiImage
        } catch {
            self.image = nil
        }
    }
}
