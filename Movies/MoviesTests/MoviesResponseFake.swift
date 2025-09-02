//
//  MoviesResponseFake.swift
//  Movies
//
//  Created by Lucas Costa on 01/09/25.
//


import Foundation

enum MoviesResponseFake {
    static func make() -> Data? {
        """
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/8jeDyvFQKgss36FbGAmGQVzPXlH.jpg",
              "genre_ids": [
                53,
                28,
                35
              ],
              "id": 1151334,
              "original_language": "en",
              "original_title": "Eenie Meanie",
              "overview": "A former teenage getaway driver gets dragged back into her unsavory past when a former employer offers her a chance to save the life of her chronically unreliable ex-boyfriend.",
              "popularity": 700.4984,
              "poster_path": "/12Va3oO3oYUdOd75zM57Nx1976a.jpg",
              "release_date": "2025-08-21",
              "title": "Eenie Meanie",
              "video": false,
              "vote_average": 6.485,
              "vote_count": 103
            }
          ],
          "total_pages": 52194,
          "total_results": 1043873
        }
        """.data(using: .utf8)
    }
}
