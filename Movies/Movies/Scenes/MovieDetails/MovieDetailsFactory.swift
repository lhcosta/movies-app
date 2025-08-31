//
//  MovieDetailsFactory.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//
import UIKit

struct MovieDetails {
    let imageURL: URL?
    let description: String
    let title: String
    let releaseDate: Date
}

protocol MovieDetailsFactoring {
    func make(details: MovieDetails) -> MovieDetailsViewController
}

struct MovieDetailsFactory: MovieDetailsFactoring  {
    func make(details: MovieDetails) -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel(details: details)
        let controller = MovieDetailsViewController(viewModel: viewModel)
        viewModel.delegate = controller
        return controller
    }
}
