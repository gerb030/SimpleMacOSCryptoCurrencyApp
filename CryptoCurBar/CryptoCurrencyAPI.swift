import Foundation

class CryptoCurrencyAPI {
    let BASE_URL = "https://min-api.cryptocompare.com/data/price"
    
    func fetchCrypto(_ currency: String, success: @escaping (CryptoPrice) -> Void) {
        let session = URLSession.shared
        // url-escape the query string we're passed
        let escapedCurrency = currency.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        let url = URL(string: "\(BASE_URL)?fsym=\(escapedCurrency!)&tsyms=EUR")
        //NSLog("\(BASE_URL)?fsym=\(escapedCurrency!)&tsyms=EUR")
        let task = session.dataTask(with: url!) { data, response, err in
            // first check for a hard error
            if let error = err {
                NSLog("crypto currency api error: \(error)")
            }
            
            // then check the response code
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: // all good!
                    if let weather = self.cryptoPriceFromJSONData(data!) {
                        success(weather)
                    }
                default:
                    NSLog("crypto currency api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        task.resume()
    }
    
    func cryptoPriceFromJSONData(_ data: Data) -> CryptoPrice? {
        typealias JSONDict = [String:AnyObject]
        let json : JSONDict
        
        do {
            json = try JSONSerialization.jsonObject(with: data, options: []) as! JSONDict
        } catch {
            NSLog("JSON parsing failed: \(error)")
            return nil
        }
        
        var formattedPrice: String
        let valueRetrieved = json["EUR"]
        if (valueRetrieved != nil) {
            formattedPrice = String(format: "%.3f", valueRetrieved as! Float)
        } else {
            formattedPrice = "error!"
        }
        let crypto = CryptoPrice(
            currentPriceEUR: formattedPrice
        )
        
        return crypto
    }
    
}
