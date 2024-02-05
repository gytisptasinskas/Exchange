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
            ScrollView {
                ForEach(viewModel.filteredCurrencies, id: \.self) { currency in
                    Button {
                        if viewModel.selectedFromCurrency == nil {
                            viewModel.selectedFromCurrency = currency
                        } else {
                            viewModel.selectedToCurrency = currency
                            if let fromCurrency = viewModel.selectedFromCurrency, let toCurrency = viewModel.selectedToCurrency {
                                viewModel.addCurrencyPair(from: fromCurrency, to: toCurrency)
                                dismiss()
                            }
                        }
                    } label: {
                        HStack(spacing: 20) {
                            Text(currency.code)
                                .foregroundStyle(Color(uiColor: .systemGray))
                            Text(currency.name)
                                .foregroundStyle(Color(uiColor: .label))
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .searchable(text: $viewModel.searchText, prompt: "Search for currency")
                .navigationTitle("Select Currency")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
                .onChange(of: viewModel.searchText, { oldValue, newValue in
                    viewModel.filterCurrencies(searchQuery: newValue)
                })
            }
        }
    }
}

#Preview {
    CurrencyListView(viewModel: HomeViewModel())
}
