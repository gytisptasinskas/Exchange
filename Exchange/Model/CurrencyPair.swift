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
}
