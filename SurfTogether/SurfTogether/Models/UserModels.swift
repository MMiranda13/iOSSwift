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
    //let quiver: Quiver?
    
}

struct Quiver: Decodable {
    let size: String
    let brand: String
    let model: String
    let dateField: TimeInterval
    let wetsuit: Wetsuit?
}

struct Wetsuit: Decodable {
    let brand: String
    let thickness: String
}

struct Docid {
    static var userID = "something"
}
