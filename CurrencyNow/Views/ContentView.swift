//
//  ContentView.swift
//  CurrencyNow
//
//  Created by Anastasia Mousa on 17/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    
    let currencies = ["USD", "EUR", "GBP", "CHF", "JPY"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("💱 CurrencyNow")
                .font(.largeTitle.bold())
                .padding(.top)
            
            TextField("Amount", text: $viewModel.amount)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.horizontal)
            
            HStack {
                Picker("From", selection: $viewModel.fromCurrency) {
                    ForEach(currencies, id: \.self) { Text($0) }
                }
                .pickerStyle(MenuPickerStyle())
                
                Image(systemName: "arrow.right")
                
                Picker("To", selection: $viewModel.toCurrency) {
                    ForEach(currencies, id: \.self) { Text($0) }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal)
            
            Button("Convert") {
                withAnimation { viewModel.convert() }
            }
            
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Text("= \(viewModel.result) \(viewModel.toCurrency)")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
                .transition(.opacity)
            
            Spacer()
        }
    }
}
