//
//  ForecastViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 29/09/2022.
//

import UIKit

class ForecastViewController: UIViewController {

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swellDirectionView.layer.cornerRadius = 12
        waveHeightView.layer.cornerRadius = 12
        wavePeriodView.layer.cornerRadius = 12
        windView.layer.cornerRadius = 12
        
       // rulerImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    

   

}
