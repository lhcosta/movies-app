//
//  File.swift
//  Movies
//
//  Created by Lucas Costa on 02/09/25.
//


import SwiftUI

extension UIImageView {
    func load(from url: URL?) {
        do {
            let image = try ImageService.shared.fetch(url: url)
            self.image = ImageRenderer(content: image).uiImage
        } catch {
            self.image = nil
        }
    }
}
