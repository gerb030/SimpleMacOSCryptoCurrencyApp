//
//  StatusMenuController.swift
//  CryptoCurBar
//
//  Created by Gerben de Graaf on 13/01/2018.
//  Copyright © 2018 Gerben de Graaf. All rights reserved.
//

struct CryptoPrice {
    var currentPriceEUR: String
}

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var quitClicked: NSMenuItem!
    
    var timer: Timer!
    
    var selectedCurrency = "ETH"
    
    let cryptoCurrencyAPI = CryptoCurrencyAPI()
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        let icon = NSImage(named: NSImage.Name(rawValue: "statusIcon"))
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.title = "Loading..."
        statusItem.menu = statusMenu
        
        updateCryptoPrice()
        timer?.invalidate()   // just in case you had existing `NSTimer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateCryptoPrice), userInfo: nil, repeats: true)
    }

    @objc func updateCryptoPrice() {
        cryptoCurrencyAPI.fetchCrypto(self.selectedCurrency) { cryptoPrice in
            self.statusItem.title = "\(self.selectedCurrency) €\(cryptoPrice.currentPriceEUR)"
        }
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        updateCryptoPrice()
    }

    @IBAction func quitClicked(sender: NSMenuItem) {
        timer?.invalidate()
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func defaultCurrencyPicked(_ sender: NSMenuItem) {
        switch sender.title {
        case "0x":
            self.selectedCurrency = "ZRX"
        case "AppCoin":
            self.selectedCurrency = "APPC"
        case "Bitcoin":
            self.selectedCurrency = "BTC"
        case "Bitcoin Cash":
            self.selectedCurrency = "BCH"
        case "Cardano":
            self.selectedCurrency = "ADA"
        case "Ethereum":
            self.selectedCurrency = "ETH"
        case "Golem":
            self.selectedCurrency = "GNT"
        case "Gulden":
            self.selectedCurrency = "NLG"
        case "Litecoin":
            self.selectedCurrency = "LTC"
        case "Ripple":
            self.selectedCurrency = "XRP"
        case "Stellar":
            self.selectedCurrency = "XLM"
        case "Neo":
            self.selectedCurrency = "NEO"
        case "Network Request":
            self.selectedCurrency = "REQ"
        case "Verge":
            self.selectedCurrency = "XVG"
        default:
            self.selectedCurrency = "BTC"
        }
        updateCryptoPrice()
    }

}


/*
 https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=NLG&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=BCH&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=XVG&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=XRP&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=APPC&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=LTC&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=NEO&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=XLM&tsyms=EUR
 https://min-api.cryptocompare.com/data/price?fsym=REQ&tsyms=EUR
 */
