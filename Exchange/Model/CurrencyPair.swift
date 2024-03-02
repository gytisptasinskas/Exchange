//
//  CurrencyPair.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import Foundation

struct CurrencyPair: Identifiable {
    let id = UUID()
    var fromCurrency: Currency
    var toCurrency: Currency
    var exchangeRate: Double?
}

struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
    let base: String
    let date: String
}



