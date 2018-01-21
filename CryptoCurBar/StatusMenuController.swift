//
//  StatusMenuController.swift
//  CryptoCurBar
//
//  Created by Gerben de Graaf on 13/01/2018.
//  Copyright © 2018 Gerben de Graaf. All rights reserved.
//

struct CryptoPrice {
    var currentPriceEUR: Float
}

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let cryptoCurrencyAPI = CryptoCurrencyAPI()
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        let icon = NSImage(named: NSImage.Name(rawValue: "statusIcon"))
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.title = "ETH loading..."
        
        updateCryptoPrice()
    }

    func updateCryptoPrice() {
        cryptoCurrencyAPI.fetchCrypto("ETH") { cryptoPrice in
            //self.statusItem.title = "ETH € \(cryptoPrice.currentPriceEUR)"
            
        }
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        updateCryptoPrice()
    }

    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}


// https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=NLG&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=BCH&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=XVG&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=XRP&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=APPC&tsyms=EUR
//https://min-api.cryptocompare.com/data/price?fsym=LTC&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=NEO&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=XLM&tsyms=EUR
// https://min-api.cryptocompare.com/data/price?fsym=REQ&tsyms=EUR
