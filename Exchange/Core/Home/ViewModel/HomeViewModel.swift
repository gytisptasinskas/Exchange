//
//  HomeViewModel.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isCurrencyListShowing: Bool = false
    @Published var currencies: [Currency] = []
    @Published var filteredCurrencies: [Currency] = []
    @Published var selectedFromCurrency: Currency?
    @Published var selectedToCurrency: Currency?
    @Published var searchText = ""
    @Published var currencyPairs: [CurrencyPair] = []
    
    init() {
        loadCurrencies()
    }
    
    func loadCurrencies() {
        guard let url = Bundle.main.url(forResource: "Currencies", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load Currencies.json from bundle.")
            return
        }
        
        do {
            self.currencies = try JSONDecoder().decode([Currency].self, from: data)
            filteredCurrencies = currencies
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func filterCurrencies(searchQuery: String) {
        if searchQuery.isEmpty {
            filteredCurrencies = currencies
        } else {
            filteredCurrencies = currencies.filter { currency in
                return currency.code.localizedCaseInsensitiveContains(searchQuery) ||
                       currency.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    
    func addCurrencyPair(from: Currency, to: Currency) {
        let pair = CurrencyPair(fromCurrency: from, toCurrency: to)
        currencyPairs.append(pair)
        selectedFromCurrency = nil
        selectedToCurrency = nil
    }
    
    func deletePairs(at offsets: IndexSet) {
         currencyPairs.remove(atOffsets: offsets)
     }
}
