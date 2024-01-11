//
//  Booking.swift
//  CareGuide
//
//  Created by mobileProg on 06/12/2023.
//

import Foundation

class Booking {
    var status : Status
    var patient : User?
    var name: String
    var testType : String
    var date : String
    var location : String
    var price : String
    var include: String
    
    init(status: Status, name : String, testType: String, date: String, location: String, price:String, include:String, patient: User?) {
        self.status = status
        self.name = name
        self.testType = testType
        self.date = date
        self.location = location
        self.price = price
        self.patient = patient
        self.include = include
    }
}
//enumaration for Bookings 3 states
enum Status : String {
    case cancelled
    case compleleted
    case upcoming
}

