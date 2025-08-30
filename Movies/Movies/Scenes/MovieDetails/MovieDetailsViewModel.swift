//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//
import Foundation

protocol MovieDetailsDelegate: AnyObject {
    func updateView(title: String, subtitle: String, description: String)
}

protocol MovieDetailsViewModeling {
    func start()
}

final class MovieDetailsViewModel: MovieDetailsViewModeling {
    private let details: MovieDetails
    weak var delegate: MovieDetailsDelegate?
    
    init(details: MovieDetails) {
        self.details = details
    }
    
    func start() {
        delegate?.updateView(
            title: details.title,
            subtitle: details.description,
            description: "Criado em \(details.releaseDate)"
        )
    }
}
