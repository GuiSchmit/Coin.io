//
//  ViewController.swift
//  Coin.io
//
//  Created by Guilherme Schmit Dall Agnol on 12.01.23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var basePicker: UIPickerView!
    @IBOutlet weak var quotePicker: UIPickerView!
    @IBOutlet weak var valueLabel: UILabel!
    
    var coinManager = CoinManager(baseCurrency: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        basePicker.dataSource = self
        basePicker.delegate = self
        quotePicker.dataSource = self
        quotePicker.delegate = self
        basePicker.tag = 1
        quotePicker.tag = 2
    }
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinData) {
        DispatchQueue.main.async {
            let formatted = String(format: "%.2f", coin.rate)
            self.valueLabel.text = formatted
            self.baseLabel.text = coin.asset_id_base
            self.quoteLabel.text = coin.asset_id_quote
        }
    }
        func didFailWithError(error: Error) {
            print(error)
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return coinManager.currencyArray.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedCurrency = coinManager.currencyArray[row]
            if pickerView.tag == 1 {
                coinManager.getBaseCurrency(for: selectedCurrency)
            } else if pickerView.tag == 2 {
                coinManager.getCoinPrice(for: selectedCurrency)
            }
            
        }
        
    }

