//
//  Booking.swift
//  CareGuide
//
//  Created by mobileProg on 06/12/2023.
//

import Foundation

class Booking {
    var status : Status
    var patient : String
    var name: String
    var testType : String
    var date : String
    var location : String
    var price : String
    
    init(status: Status, name : String, testType: String, date: String, location: String, price:String, patient: String) {
        self.status = status
        self.name = name
        self.testType = testType
        self.date = date
        self.location = location
        self.price = price
        self.patient = patient
    }
}
enum Status : String {
    case cancelled
    case compleleted
    case upcoming
}
