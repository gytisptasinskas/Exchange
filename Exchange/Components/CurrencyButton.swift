//
//  CurrencyButton.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import SwiftUI

enum ButtonLayout {
    case expanded
    case compact
}

struct CurrencyButton: View {
    var layout: ButtonLayout
    
    var body: some View {
        switch layout {
        case .expanded:
            // Expanded Button
            VStack {
                Button {
                    print("Something should happen")
                } label: {
                    Image(systemName: "plus")
                        .modifier(CurrencyButtonModifier())
                }
                
                
                Text("Add Currency Pair")
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                
                Text("Choose a currency pair to compare their \nlive rates")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(uiColor: .systemGray))
                
            }
        case .compact:
            // Compact Button
            Button {
                print("Something should happen")
            } label: {
                HStack(spacing: 20) {
                    Image(systemName: "plus")
                        .modifier(CurrencyButtonModifier())
                    
                    Text("Add Currency Pair")
                        .font(.headline)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                }
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
           
            }
        }
    }
}

#Preview {
    CurrencyButton(layout: .compact)
}
