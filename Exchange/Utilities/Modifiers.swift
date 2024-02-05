//
//  Modifiers.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import SwiftUI

struct CurrencyButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(width: 40, height: 40)
            .foregroundStyle(.white)
            .background(Color(uiColor: .systemBlue))
            .clipShape(Circle())
    }
}
