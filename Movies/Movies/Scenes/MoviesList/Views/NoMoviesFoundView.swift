//
//  NoMoviesFoundView.swift
//  Movies
//
//  Created by Lucas Costa on 31/08/25.
//

import SwiftUI

struct NoMoviesFoundView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "film.fill")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("Nenhum filme encontrado")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text("Tente ajustar os filtros de busca ou verifique sua conexão com a internet.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    NoMoviesFoundView()
}
