//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Dinis Henriques on 18/07/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1DecimalPlace
        
    }
    
    mutating func calculateBMI(height: Float, weight: Float) {
        
        let bmiValue = weight / pow(height, 2)
        
        let color = (underweight: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), healthy: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), overweight: #colorLiteral(red: 0.6068438888, green: 0.1102350578, blue: 0.1197155192, alpha: 1))
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "EAAATT", color: color.underweight)
            
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Good Job mate!", color: color.healthy)
            
        }else {
            bmi = BMI(value: bmiValue, advice: "No more cookies", color: color.overweight)
        }
    }
        func getAdvice() -> String {
            return bmi?.advice ?? "No advice"
            
        }
        
        func getColor() -> UIColor {
            return bmi?.color ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        
    
    
    
    
}
