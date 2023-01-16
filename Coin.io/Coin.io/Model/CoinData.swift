//
//  CoinData.swift
//  Coin.io
//
//  Created by Guilherme Schmit Dall Agnol on 16.01.23.
//

import Foundation

struct CoinData: Codable {
    
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}



