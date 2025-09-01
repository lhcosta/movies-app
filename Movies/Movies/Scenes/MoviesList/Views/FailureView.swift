//
//  FailureView.swift
//  Movies
//
//  Created by Lucas Costa on 31/08/25.
//
import SwiftUI

struct FailureView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 80))
                .foregroundColor(.red)
            
            VStack(spacing: 8) {
                Text("Algo deu errado")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            
            Button("Tentar Novamente") {
                retryAction()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
    }
}

#Preview {
    FailureView(message: "Nenhum filme encontrado") {}
}
