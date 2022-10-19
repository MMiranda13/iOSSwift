//
//  ForecastViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 29/09/2022.
//

import UIKit

class ForecastViewController: UIViewController, ForecastManagerDelegate {
    
    @IBOutlet weak var swellDirectionView: UIView!
    @IBOutlet weak var waveHeightView: UIView!
    @IBOutlet weak var wavePeriodView: UIView!
    @IBOutlet weak var windView: UIView!
    @IBOutlet weak var rulerImage: UIImageView!
    
    @IBOutlet weak var swellDirectionLabel: UILabel!
    @IBOutlet weak var waveHeightLabel: UILabel!
    @IBOutlet weak var wavePeriodLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    var dayIdx: Int = 0
    var hourIdx: Int = 0
    
    var forecastManager = ForecastManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchWeather()
        
    }
    
    func configureUI() {
        swellDirectionView.layer.cornerRadius = 12
        waveHeightView.layer.cornerRadius = 12
        wavePeriodView.layer.cornerRadius = 12
        windView.layer.cornerRadius = 12
        rulerImage.transform = CGAffineTransform(rotationAngle: .pi/2)
    }
    
    func fetchWeather() {
        forecastManager.delegate = self
        forecastManager.hourlyIndex = hourIdx
        forecastManager.weatherIndex = dayIdx
        forecastManager.fetchForecast()
    }
    
    func didUpdateForecast(forecast: ForecastModel) {
        DispatchQueue.main.async {
            self.swellDirectionLabel.text = forecast.swellDir
            self.waveHeightLabel.text = "\(forecast.swellHeight)m"
            self.wavePeriodLabel.text = "\(forecast.swellPeriod)s"
            self.windSpeedLabel.text = "\(forecast.windSpeed)km/h"
            self.windDirectionLabel.text = forecast.windDir
        }
        
    }
    
    
    
}



