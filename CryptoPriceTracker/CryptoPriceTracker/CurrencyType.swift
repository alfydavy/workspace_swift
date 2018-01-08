//
//  CurrencyType.swift
//  CryptoTracker
//
//  Created by Alfred David on 08/01/18.
//  
//

import UIKit

enum CurrencyType: String {
    case btc = "BTC",
    eth = "ETH",
    ltc = "LTC",
    xrp = "XRP",
    xmr = "XMR",
    neo = "NEO"
    
    var apiURL: URL? {
        let apiString = "https://min-api.cryptocompare.com/data/price?fsym=" + rawValue + "&tsyms=USD"
        return URL(string: apiString)
}


 var name: String {
    switch self {
    case .btc:
        return "Bitcoin"
    case .eth:
        return "Ethereum"
    case .ltc:
        return "Litecoin"
    case .xrp:
        return "Ripple"
    case .xmr:
        return "Monero"
    case .neo:
        return "Neo"
    }
}
    
var image: UIImage {
    switch self {
    case .btc:
        return #imageLiteral(resourceName: "Bitcoin")
    case .eth:
        return #imageLiteral(resourceName: "Ethereum")
    case .ltc:
        return #imageLiteral(resourceName: "Litecoin")
    case .xrp:
        return #imageLiteral(resourceName: "Ripple")
    case .xmr:
        return #imageLiteral(resourceName: "Monero")
    case .neo:
        return #imageLiteral(resourceName: "NEO")
    }
}


func requestValue(completion: @escaping (_ value: NSNumber?) -> Void) {
    guard let apiURL = apiURL else {
        // If we couldn't serialize the JSON set the value in the completion as nil and print the error
        completion(nil)
        print("URL Invalid")
        return
    }
        let request = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let value = json["USD"] as? NSNumber else {
                        completion(nil)
                        return
                }
                completion(value)
            } catch {
                completion(nil)
                print(error.localizedDescription)
            }
        }
        request.resume()
    }
}




