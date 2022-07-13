//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var progBar: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 10]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer ()
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes [hardness]!
        
        progBar.progress = 0.0
        progBar.isHidden = false
        
        secondsPassed = 0
        label1.text = hardness
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1

                let percentageProg = Float(self.secondsPassed) / Float(self.totalTime)
                
                self.progBar.progress = Float(percentageProg)
                
                print ("\(self.secondsPassed) seconds")
                
            } else {
                self.timer.invalidate()
                self.label1.text = "Done!"
                self.progBar.isHidden = true
                
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player.play()
                
                
            }
        }
        
        
    }
    
        
    
}

