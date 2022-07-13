//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Dinis Henriques on 13/07/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        text = q
        answer = a
    }
}
