//
//  ForecastManager.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 04/10/2022.
//

import Foundation


struct ForecastManager {
    
    let forecastURL = "https://api.worldweatheronline.com/premium/v1/marine.ashx?key=43e52d7fb66141efa52131534220610&format=json&q=41.18,-8.70"
    
    func fetchForecast() {
        let urlString = forecastURL
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: forecastURL) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(forecastData: safeData)
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(forecastData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            print(decodedData.data.weather[0].hourly[0].windspeedKmph)
        } catch {
            print(error)
        }
    }
}



