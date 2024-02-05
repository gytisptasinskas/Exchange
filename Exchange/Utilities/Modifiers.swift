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
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: 60, height: 60)
            .foregroundStyle(.white)
            .background(Color(uiColor: .systemBlue))
            .clipShape(Circle())
    }
}
