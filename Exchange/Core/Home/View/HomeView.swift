//
//  HomeView.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 10)  {
                CurrencyButton(layout: viewModel.currencyPairs.isEmpty ? .expanded : .compact, action: {
                    viewModel.resetForNewSelection()
                    viewModel.isCurrencyListShowing.toggle()
                })
                
                if !viewModel.currencyPairs.isEmpty {
                    List {
                        ForEach(viewModel.currencyPairs) { pair in
                            CurrencyPairView(
                                fromCurrency: pair.fromCurrency,
                                toCurrency: pair.toCurrency,
                                exchangeRate: pair.exchangeRate)
                        }
                        .onDelete(perform: viewModel.deletePairs)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.refreshExchangeRates()
                    }
                } else {
                    Text("Choose a currency pair to compare their \nlive rates")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color(uiColor: .systemGray))
                }
            }
            .navigationTitle("Rates & Converter")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $viewModel.isCurrencyListShowing) {
                CurrencyListView(viewModel: viewModel)
            }
        }
    }
}



#Preview {
    HomeView()
}
