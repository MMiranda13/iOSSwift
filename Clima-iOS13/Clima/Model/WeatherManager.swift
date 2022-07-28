//
//  WeatherManager.swift
//  Clima
//
//  Created by Dinis Henriques on 20/07/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=68423f54f0a2e864f697522078eab194&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    /// This starts a new requeste each time gets called
    /// - Parameter urlString: is the url the will be requested
    func performRequest(with urlString: String) {
        //1. Create URL
        
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    debugPrint ("Status Code: \(response.statusCode)")
                }
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(receivedData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            })
            

            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(receivedData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: receivedData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel (conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
