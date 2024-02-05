//
//  HomeView.swift
//  Exchange
//
//  Created by Gytis Ptasinskas on 05/02/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 10)  {
                Button {
                    print("Something should happen")
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.white)
                        .background(Color(uiColor: .systemBlue))
                        .clipShape(Circle())
                }
            
                Text("Add Currency Pair")
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                
                Text("Choose a currency pair to compare their \nlive rates")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(uiColor: .systemGray))
            }
            .navigationTitle("Rates & converter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
