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
   var timingFrom: String
   var timingTo: String
   var is247: Bool
   var password: String
   var phoneNumber: String
   var email: String
   var isLab : Bool
   var logo : String
   
   init(name: String, location: String, timingFrom: String, timingTo: String, is247: Bool, password: String, phoneNumber: String, email: String, isLab: Bool, logo : String) {
       self.name = name
       self.location = location
       self.timingFrom = timingFrom
       self.timingTo = timingTo
       self.is247 = is247
       self.password = password
       self.phoneNumber = phoneNumber
       self.email = email
       self.isLab = isLab
       self.logo = logo
   }
}

