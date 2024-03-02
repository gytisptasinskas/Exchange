//
//  HomeViewModel.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isCurrencyListShowing: Bool = false
    @Published var currencies: [Currency] = []
    @Published var filteredCurrencies: [Currency] = []
    @Published var selectedFromCurrency: Currency?
    @Published var selectedToCurrency: Currency?
    @Published var searchText = "" {
        didSet {
            filterCurrencies(searchQuery: searchText)
        }
    }
    @Published var isErrorPresenting: Bool?
    @Published var currencyPairs: [CurrencyPair] = []
    @Published var exchangeRate: Double?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectionStep: SelectionStep = .selectingFromCurrency
    
    // MARK: - Private Properties
    private var currencyRateService = CurrencyRateService()
    
    
    // MARK: - Initialization
    init() {
        loadCurrencies()
    }
    
    // MARK: - Enums
    enum SelectionStep {
        case selectingFromCurrency
        case selectingToCurrency
    }
    
    // MARK: - Published Methods
    func proceedToNextSelectionStep() {
        switch selectionStep {
        case .selectingFromCurrency:
            selectionStep = .selectingToCurrency
        case .selectingToCurrency:
            break
        }
    }
    
    func resetForNewSelection() {
        selectionStep = .selectingFromCurrency
        selectedFromCurrency = nil
        selectedToCurrency = nil
    }
    
    
    func deletePairs(at offsets: IndexSet) {
        currencyPairs.remove(atOffsets: offsets)
    }
    
    @MainActor
    func fetchExchangeRate(for pair: CurrencyPair) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let rate = try await currencyRateService.fetchExchangeRate(from: pair.fromCurrency.code, to: pair.toCurrency.code, amount: 1.0)
            exchangeRate = rate
            isLoading = false
            if let index = currencyPairs.firstIndex(where: { $0.id == pair.id }) {
                currencyPairs[index].exchangeRate = rate
            }
        } catch {
            errorMessage = "Failed to fetch exchange rate."
            isLoading = false
        }
    }
    
    func addCurrencyPair(from: Currency, to: Currency) {
        if currencyPairs.contains(where: { $0.fromCurrency == from && $0.toCurrency == to }) {
            errorMessage = "This currency pair already exists."
            return
        }
        
        let newPair = CurrencyPair(fromCurrency: from, toCurrency: to)
        currencyPairs.append(newPair)
        selectedFromCurrency = nil
        selectedToCurrency = nil
        Task {
            await fetchExchangeRate(for: newPair)
        }
    }
    
    func refreshExchangeRates() async {
        isLoading = true
        for pair in currencyPairs {
            await fetchExchangeRate(for: pair)
        }
        isLoading = false
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
        let allCurrencies = currencies
        let availableCurrencies = selectionStep == .selectingToCurrency ? allCurrencies.filter { $0 != selectedFromCurrency } : allCurrencies
        
        if searchQuery.isEmpty {
            filteredCurrencies = availableCurrencies
        } else {
            filteredCurrencies = availableCurrencies.filter { currency in
                return currency.code.localizedCaseInsensitiveContains(searchQuery) ||
                currency.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
}
