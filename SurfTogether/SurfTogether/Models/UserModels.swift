//
//  UserModels.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 13/09/2022.
//

import Foundation

struct User {
    let username: String
    let email: String
    let level: String
    let friends: Int?
    let quiver: Quiver?
    
}

struct Quiver {
    let size: Float
    let brand: String
    let model: String
    let wetsuit: String
}
