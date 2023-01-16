//
//  CoinManager.swift
//  Coin.io
//
//  Created by Guilherme Schmit Dall Agnol on 16.01.23.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinData)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    var baseCurrency: String
    let apiKey = "8A0FCFF6-43D4-4971-8569-52E04B51EB25"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    mutating func getBaseCurrency(for base: String){
        baseCurrency = base
    }
    func getCoinPrice(for quote: String) {
        let urlString = "\(baseURL)\(baseCurrency)/\(quote)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func parseJSON(_ coinData: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            return decodedData
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession (configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
}


