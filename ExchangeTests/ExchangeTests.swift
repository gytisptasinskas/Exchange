//
//  ExchangeTests.swift
//  ExchangeTests
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import XCTest
@testable import Exchange

@MainActor
final class ExchangeTests: XCTestCase {
    let viewModel = HomeViewModel()
    
    func testLoadCurrencies() {
        viewModel.loadCurrencies()
        
        XCTAssertFalse(viewModel.currencies.isEmpty, "Currencies should be loaded")
    }
    
    func testFilterCurrencies() {
        viewModel.currencies = [Currency(code: "EUR", name: "Euro", country: "", countryCode: "", flag: ""),
                                Currency(code: "USD", name: "US Dollar", country: "", countryCode: "", flag: "")]
        
        viewModel.filterCurrencies(searchQuery: "Euro")
        
        XCTAssertEqual(viewModel.filteredCurrencies.count, 1)
        XCTAssertEqual(viewModel.filteredCurrencies.first?.code, "EUR")
        XCTAssertNotEqual(viewModel.filteredCurrencies.first?.code, "USD")
    }

    func testSelectionSteps() {
        viewModel.proceedToNextSelectionStep()
        XCTAssertEqual(viewModel.selectionStep, .selectingToCurrency, "Should proceed to selecting to currency")
        
        viewModel.resetForNewSelection()
        XCTAssertEqual(viewModel.selectionStep, .selectingFromCurrency, "Should reset to selecting from currency")
    }
    
    func testAddingDuplicateCurrencyPairs() throws {
        let baseCurrency = Currency(code: "EUR", name: "Euro", country: "", countryCode: "", flag: "")
        let targetCurrency = Currency(code: "USD", name: "US Dollar", country: "", countryCode: "", flag: "")
        
        viewModel.addCurrencyPair(from: baseCurrency, to: targetCurrency)
        XCTAssertEqual(viewModel.currencyPairs.count, 1, "One currency pair should be added.")
        
        viewModel.addCurrencyPair(from: baseCurrency, to: targetCurrency)
        
        XCTAssertEqual(viewModel.currencyPairs.count, 1, "Duplicate currency pair should not be added.")
        XCTAssertNotNil(viewModel.errorMessage, "An error message should be set when trying to add a duplicate pair.")
    }
}
