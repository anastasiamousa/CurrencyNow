//
//  CurrencyAPIService.swift
//  CurrencyNow
//
//  Created by Anastasia Mousa on 17/5/25.
//

import Foundation

class CurrencyAPIService {
    func convert(from: String, to: String, amount: Double, completion: @escaping (Double?) -> Void) {
        let urlString = "https://api.exchangerate.host/convert?from=\(from)&to=\(to)&amount=\(amount)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  let decoded = try? JSONDecoder().decode(CurrencyConversionResponse.self, from: data),
                  error == nil else {
                completion(nil)
                return
            }
            completion(decoded.result)
        }.resume()
    }
}
