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
    var action: () -> Void
    
    var body: some View {
        switch layout {
        case .expanded:
            // Expanded Button
            VStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "plus")
                        .modifier(CurrencyButtonModifier())
                }
                
                Text("Add Currency Pair")
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
        case .compact:
            // Compact Button
            Button {
                action()
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
    CurrencyButton(layout: .compact, action: { })
}
