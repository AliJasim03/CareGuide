//
//  User.swift
//  CareGuide
//
//  Created by Ali Jasim on 09/10/2023.
//

import Foundation
class User {
    var fullName: String
    var email: String
    var gender: String
    var dateOfBirth: String
    var phoneNumber: String

    init(email: String, fullName: String, dateOfBirth: String, gender: String, phoneNumber: String) {
        self.email = email
        self.fullName = fullName
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.phoneNumber = phoneNumber
    }
}
