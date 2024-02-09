//
//  CurrencyRate.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 06/02/2024.
//

import Foundation

class CurrencyRateService {
    let headers = [
        "X-RapidAPI-Key": "b0441acdb1msh70d9957e8759edep19ec80jsn299e0bab0fe8",
        "X-RapidAPI-Host": "currency-exchange.p.rapidapi.com"
    ]
    
    func fetchExchangeRate(from: String, to: String, amount: Double) async throws -> Double {
        let urlString = "https://currency-exchange.p.rapidapi.com/exchange?from=\(from)&to=\(to)&q=\(amount)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let (data, response) = try await URLSession.shared.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        guard let rateString = String(data: data, encoding: .utf8), let rate = Double(rateString) else {
            throw URLError(.cannotParseResponse)
        }

        return rate
    }
}



