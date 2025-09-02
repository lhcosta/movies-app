//
//  MovieDetailsViewControllerRepresentable.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import SwiftUI

// Demonstrando o uso de SwiftUI com feature em UIKit
struct MovieDetailsView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MovieDetailsViewController
    private let factory: MovieDetailsFactoring
    private let details: MovieDetails
    
    init(details: MovieDetails, factory: MovieDetailsFactoring = MovieDetailsFactory()) {
        self.factory = factory
        self.details = details
    }
    
    func makeUIViewController(context: Context) -> MovieDetailsViewController {
        factory.make(details: details)
    }
    
    func updateUIViewController(_ uiViewController: MovieDetailsViewController, context: Context) {
        /*without implementation*/
    }
}
