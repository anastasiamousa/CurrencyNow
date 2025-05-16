//
//  CurrencyConverterViewModel.swift
//  CurrencyNow
//
//  Created by Anastasia Mousa on 17/5/25.
//

import Foundation
import Combine

class CurrencyConverterViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var fromCurrency: String = "USD"
    @Published var toCurrency: String = "EUR"
    @Published var result: String = "-"
    
    private let service = CurrencyAPIService()
    private var cancellables = Set<AnyCancellable>()
    
    func convert() {
        guard let amountValue = Double(amount) else {
            result = "Invalid amount"
            return
        }
        
        service.convert(from: fromCurrency, to: toCurrency, amount: amountValue) { [weak self] converted in
            DispatchQueue.main.async {
                if let value = converted {
                    self?.result = String(format: "%.2f", value)
                } else {
                    self?.result = "Error"
                }
            }
        }
    }
}
