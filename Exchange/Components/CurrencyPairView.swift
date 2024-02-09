//
//  CurrencyPairView.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import SwiftUI

struct CurrencyPairView: View {
    var fromCurrency: Currency
    var toCurrency: Currency
    var exchangeRate: Double?
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("1 \(fromCurrency.code)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                if let rate = exchangeRate {
                    Text("\(rate, specifier: "%.4f")")
                        .font(.title2)
                        .fontWeight(.semibold)
                } else {
                    Text("Fetching...")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            
            HStack {
                Text(fromCurrency.name)
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .systemGray))
                Spacer()
                Text(toCurrency.name)
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .systemGray))
                Text(toCurrency.code)
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .systemGray))
            }
        }
    }
}
