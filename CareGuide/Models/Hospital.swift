//
//  Hospital.swift
//  CareGuide
//
//  Created by Ali Jasim on 24/10/2023.
//

import Foundation
class Hospital {
    var name: String
    var location: String
    var timing: String
    var password: String
    var phoneNumber: String
    var email: String
    var isLab : String
  //  var logo : UIImage
    
    init(name: String, location: String, timing: String,  password: String, phoneNumber: String, email: String, isLab: String)/*+logo*/ {
        self.name = name
        self.location = location
        self.timing = timing
        self.password = password
        self.phoneNumber = phoneNumber
        self.email = email
        self.isLab = isLab
        //   self.logo = logo
    }
}
