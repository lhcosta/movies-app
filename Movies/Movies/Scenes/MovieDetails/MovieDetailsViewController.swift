//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let viewModel: MovieDetailsViewModeling
    
    init(viewModel: MovieDetailsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.start()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),

            contentStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

// MARK: MovieDetailsDelegate
extension MovieDetailsViewController: MovieDetailsDelegate {
    func updateView(title: String, subtitle: String, description: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        descriptionLabel.text = description
    }
}
