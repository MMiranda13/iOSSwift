//
//  ForecastData.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 07/10/2022.
//

import Foundation

struct ForecastData: Decodable {
    let data: FData

}

struct FData: Decodable {
    let weather: [Weather]
}

struct Weather: Decodable {
    let hourly: [Hourly]
}

struct Hourly: Decodable {
    let time: String
    let windspeedKmph: String
    let winddir16Point: String
    let swellHeight_m: String
    let swellDir16Point: String
    let swellPeriod_secs: String
    let waterTemp_C: String
    let uvIndex: String
}
