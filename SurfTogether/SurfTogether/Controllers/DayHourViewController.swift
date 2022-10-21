//
//  DayHourViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 17/10/2022.
//

import UIKit
import Foundation


class DayHourViewController: UIViewController {
    
    let hour = ["0:00","3:00","6:00", "9:00", "12:00", "15:00", "18:00","21:00"]
    var day = [String]()
    
    
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var hourTextField: UITextField!
    
    var dayPickerView = UIPickerView()
    var hourPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        availableDays()
        
        dayTextField.inputView = dayPickerView
        hourTextField.inputView = hourPickerView
        
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        
        hourPickerView.delegate = self
        hourPickerView.dataSource = self
        
        dayPickerView.tag = 1
        hourPickerView.tag = 2
        
    }
    
    func availableDays() {
        let calendar = Calendar.current
        let actualDate = calendar.startOfDay(for: Date())
        
        let availableDates = [
            actualDate,
            calendar.date(byAdding: .day, value: 1, to: actualDate),
            calendar.date(byAdding: .day, value: 2, to: actualDate),
            calendar.date(byAdding: .day, value: 3, to: actualDate),
            calendar.date(byAdding: .day, value: 4, to: actualDate),
            calendar.date(byAdding: .day, value: 5, to: actualDate),
            calendar.date(byAdding: .day, value: 6, to: actualDate)
        ].compactMap({$0})
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        day = availableDates.compactMap { availableDate in
            formatter.string(from: availableDate)
        }
    }
    
    
    @IBAction func forecastPressed(_ sender: UIButton) {
        if dayTextField.text!.isEmpty || hourTextField.text!.isEmpty {
            dayTextField.placeholder = "Insert Day please"
            hourTextField.placeholder = "Insert Hour please"
        } else {
            performSegue(withIdentifier: "goToForecast", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToForecast", let forecastVC = segue.destination as? ForecastViewController {
            let selectedDay = dayPickerView.selectedRow(inComponent: 0)
            let selectedHour = hourPickerView.selectedRow(inComponent: 0)
            forecastVC.dayIdx = selectedDay
            forecastVC.hourIdx = selectedHour
        }
        super.prepare(for: segue, sender: sender)
    }
}

extension DayHourViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return day.count
        default:
            return hour.count
            
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView.tag {
        case 1:
            return day[row]
        case 2:
            return hour[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 1:
            dayTextField.text = day[row]
//            let dayIndex = Int(day.firstIndex(of: day[row]) ?? 0)
//            let forecastVC = ForecastViewController()
//            forecastVC.dIndex = dayIndex
//            print(dayIndex)
//            dayTextField.resignFirstResponder()
        case 2:
            hourTextField.text = hour[row]
//            let hourIndex = Int(hour.firstIndex(of: hour[row]) ?? 0)
//            let forecastVC = ForecastViewController()
//            forecastVC.hIndex = hourIndex
//            print(hourIndex)
//            hourTextField.resignFirstResponder()
        default:
            return
        }
        
        view.endEditing(false)
    }
}

