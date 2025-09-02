//
//  APIToken.swift
//  CoreNetwork
//
//  Created by Lucas Costa on 02/09/25.
//
import Foundation

enum APIToken {
    static var value: String {
        guard let url = Bundle.module.url(forResource: "Secrets", withExtension: "plist"),
              let dict = NSDictionary(contentsOf: url),
              let token = dict["API_TOKEN"] as? String else {
            fatalError("❌ API_TOKEN não encontrado, faça a criação do arquivo Secrets.plist e adicione o seu token")
        }
        return token
    }
}
