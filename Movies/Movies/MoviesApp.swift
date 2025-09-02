//
//  MoviesApp.swift
//  Movies
//
//  Created by Lucas Costa on 30/08/25.
//

import SwiftUI

@main
struct MoviesApp: App {
    @StateObject
    private var container = DependencyContainer.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MoviesListView(
                    viewModel: MoviesListViewModel(
                        service: MoviesListService(resolver: container),
                        resolver: container
                    )
                )
            }
        }
    }
}
