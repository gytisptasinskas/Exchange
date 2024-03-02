//
//  CurrencyListView.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import SwiftUI

struct CurrencyListView: View {
    @StateObject var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.selectionStep == .selectingFromCurrency {
                    currencySelectionList(currencies: viewModel.filteredCurrencies, title: "Select From Currency")
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                } else {
                    currencySelectionList(currencies: viewModel.filteredCurrencies, title: "Select To Currency")
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                }
            }
            .animation(.easeInOut, value: viewModel.selectionStep)
            .navigationTitle(viewModel.selectionStep == .selectingFromCurrency ? "Select From Currency" : "Select To Currency")
            .searchable(text: $viewModel.searchText, prompt: "Search currencies...")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func currencySelectionList(currencies: [Currency], title: String) -> some View {
        let availableCurrencies = viewModel.selectionStep == .selectingToCurrency ? currencies.filter { $0 != viewModel.selectedFromCurrency } : currencies

        return ScrollView {
            ForEach(availableCurrencies, id: \.self) { currency in
                Button {
                    withAnimation {
                        updateCurrencySelection(with: currency)
                    }
                } label: {
                    currencyRow(for: currency)
                }
            }
        }
    }
    
    private func currencyRow(for currency: Currency) -> some View {
        HStack(spacing: 20) {
            Image(base64Str: currency.flag ?? "")
            Text(currency.code)
                .foregroundStyle(Color(uiColor: .systemGray))
            Text(currency.name)
                .foregroundStyle(Color(uiColor: .label))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
    }
    
    private func updateCurrencySelection(with currency: Currency) {
        if viewModel.selectionStep == .selectingFromCurrency {
            viewModel.selectedFromCurrency = currency
            viewModel.selectionStep = .selectingToCurrency
        } else {
            viewModel.selectedToCurrency = currency
            completeCurrencySelection()
        }
        viewModel.searchText = ""
    }
    
    private func completeCurrencySelection() {
        if let fromCurrency = viewModel.selectedFromCurrency, let toCurrency = viewModel.selectedToCurrency {
            viewModel.addCurrencyPair(from: fromCurrency, to: toCurrency)
            viewModel.resetForNewSelection()
            dismiss()
        }
    }
}

#Preview {
    CurrencyListView(viewModel: HomeViewModel())
}
