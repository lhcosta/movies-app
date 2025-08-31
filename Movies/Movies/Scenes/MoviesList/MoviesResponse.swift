//
//  MoviesResponse.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import Foundation

struct MoviesResponse {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

struct Movie: Identifiable, Hashable {
    let id: Int
    let imagePath: String?
    let release: Date
    let title: String
    let overview: String
}
