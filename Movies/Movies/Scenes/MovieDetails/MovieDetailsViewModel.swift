//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//
import Foundation

protocol MovieDetailsDelegate: AnyObject {
    func updateView(
        title: String,
        subtitle: String,
        description: String,
        imageURL: URL?
    )
}

protocol MovieDetailsViewModeling {
    func start()
}

final class MovieDetailsViewModel: MovieDetailsViewModeling {
    private let details: MovieDetails
    weak var delegate: MovieDetailsDelegate?
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }()
    
    init(details: MovieDetails) {
        self.details = details
    }
    
    func start() {
        delegate?.updateView(
            title: details.title,
            subtitle: details.description,
            description: "Criado em \(dateFormatter.string(from: details.releaseDate))",
            imageURL: details.imageURL
        )
    }
}
