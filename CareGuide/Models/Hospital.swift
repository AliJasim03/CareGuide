//
//  Hospital.swift
//  CareGuide
//
//  Created by Ali Jasim on 24/10/2023.
//

import Foundation

class Hospital: Equatable, Codable {
    
    static func == (lhs: Hospital, rhs: Hospital) -> Bool {
        lhs.name == rhs.name
    }
    
    var name: String
    var location: String
    var timing: String
    var is247: Bool
    var password: String
    var phoneNumber: String
    var email: String
    var isLab : Bool
    var logo : String
    var uid:String
    init(name: String, location: String,timing: String
         , is247: Bool, password: String, phoneNumber: String, email: String, isLab: Bool, logo : String,uid:String) {
        self.name = name
        self.location = location
        self.timing = timing
        self.is247 = is247
        self.password = password
        self.phoneNumber = phoneNumber
        self.email = email
        self.isLab = isLab
        self.logo = logo
        self.uid  = uid
    }
}

