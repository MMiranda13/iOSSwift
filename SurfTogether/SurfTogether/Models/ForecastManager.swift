//
//  ForecastManager.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 04/10/2022.
//

import Foundation

protocol ForecastManagerDelegate: AnyObject {
    func didUpdateForecast(forecast: ForecastModel)
}

final class ForecastManager {
    
    var task: URLSessionDataTask?
    var weatherIndex = 0
    var hourlyIndex = 0
    
    let forecastURL = "https://api.worldweatheronline.com/premium/v1/marine.ashx?key=43e52d7fb66141efa52131534220610&format=json&q=41.18,-8.70"
    
    weak var delegate: ForecastManagerDelegate?
    
    func fetchForecast() {
        let urlString = forecastURL
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: forecastURL) {
            
            let session = URLSession(configuration: .default)
            
            self.task = session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else {return}
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let forecast = self.parseJSON(forecastData: safeData) {
                        self.delegate?.didUpdateForecast(forecast: forecast)
                    }
                }
            }
            task?.resume()
        }
        
    }
    
    func parseJSON(forecastData: Data) -> ForecastModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            
            let time = decodedData.data.weather[weatherIndex].hourly[hourlyIndex].time
            let windspeedKmph = decodedData.data.weather[weatherIndex].hourly[hourlyIndex].windspeedKmph
            let winddir16Point = decodedData.data.weather[weatherIndex].hourly[hourlyIndex].winddir16Point
            let swellHeight_m = decodedData.data.weather[weatherIndex].hourly[hourlyIndex].swellHeight_m
            let swellDir16Point = decodedData.data.weather[weatherIndex].hourly[hourlyIndex].swellDir16Point
            let swellPeriod_secs = decodedData.data.weather[weatherIndex].hourly[hourlyIndex].swellPeriod_secs
            let waterTemp_C = decodedData.data.weather[weatherIndex].hourly[hourlyIndex].waterTemp_C
            let uvIndex = decodedData.data.weather[weatherIndex].hourly[hourlyIndex].uvIndex
            let date = decodedData.data.weather[weatherIndex].date
            
            let forecast = ForecastModel(hour: time, windSpeed: windspeedKmph, windDir: winddir16Point, swellHeight: swellHeight_m, swellDir: swellDir16Point, swellPeriod: swellPeriod_secs, waterTemp: waterTemp_C, uv: uvIndex, day: date)
            print(weatherIndex)
            print(hourlyIndex)
            print(forecast.hour)
            return forecast
        } catch {
            print(error)
            return nil
        }
    }
}



