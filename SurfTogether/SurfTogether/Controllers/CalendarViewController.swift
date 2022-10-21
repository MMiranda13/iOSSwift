//
//  CalendarViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 20/10/2022.
//

import UIKit
import EventKit
import EventKitUI

class CalendarViewController: UIViewController, EKEventEditViewDelegate {

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            controller.dismiss(animated: true, completion: nil)
        }
        let eventStore = EKEventStore()
        var time = Date()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
       }
    
    @IBAction func addSurfSessionPressed(_ sender: UIButton) {
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
            DispatchQueue.main.async {
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: self.eventStore)
                    event.title = "Surf Session"
                    event.startDate = self.time
                    event.url = URL(string: "https://apple.com")
                    event.endDate = self.time
                    
                    
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = self.eventStore
                    eventController.editViewDelegate = self
                    
                    self.present(eventController, animated: true, completion: nil)
                    
                }
            }
        })
    }
    
    }
    

 


