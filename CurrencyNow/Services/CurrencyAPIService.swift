//
//  CurrencyAPIService.swift
//  CurrencyNow
//
//  Created by Anastasia Mousa on 17/5/25.
//

import Foundation

class CurrencyAPIService {
    func convert(from: String, to: String, amount: Double, completion: @escaping (Double?) -> Void) {
        let apiKey = "34b03491320be6dfb59351e4af3a8971"
        let urlString = "https://api.exchangerate.host/convert?access_key=\(apiKey)&from=\(from)&to=\(to)&amount=\(amount)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ No data received")
                completion(nil)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(CurrencyConversionResponse.self, from: data)
                print("✅ Decoded result: \(decoded.result ?? 0)")
                completion(decoded.result)
            } catch {
                print("❌ JSON decoding failed: \(error.localizedDescription)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("✅ Raw JSON response: \(jsonString)")
                }
                completion(nil)
            }
        }.resume()
    }
}

