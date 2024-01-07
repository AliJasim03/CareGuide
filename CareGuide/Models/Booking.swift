//
//  Booking.swift
//  CareGuide
//
//  Created by mobileProg on 06/12/2023.
//

import Foundation

class Booking {
    var status : Status
    var name: String
    var testType : String
    var date : String
    var location : String
    var Price : String
    
    init(status: Status, name : String, testType: String, date: String, location: String, Price: String) {
        self.status = status
        self.name = name
        self.testType = testType
        self.date = date
        self.location = location
        self.Price = Price
    }
}
enum Status {
    case cancelled
    case compleleted
    case upcoming
}
