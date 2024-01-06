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
    
    init(status: Status, name : String, testType: String, date: String, location: String) {
        self.status = status
        self.name = name
        self.testType = testType
        self.date = date
        self.location = location
    }
}
enum Status : String {
    case Cancelled
    case Compleleted
    case Upcoming
}
