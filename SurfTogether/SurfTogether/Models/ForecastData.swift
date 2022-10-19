//
//  ForecastData.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 07/10/2022.
//

import Foundation

struct ForecastData: Codable {
    let data: FData

}

struct FData: Codable {
    let weather: [Weather]
}

struct Weather: Codable {
    let hourly: [Hourly]
    let date: String
}

struct Hourly: Codable {
    let time: String
    let windspeedKmph: String
    let winddir16Point: String
    let swellHeight_m: String
    let swellDir16Point: String
    let swellPeriod_secs: String
    let waterTemp_C: String
    let uvIndex: String
}
