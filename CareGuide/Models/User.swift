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
    var age: Int
    var phoneNumber: String

    init(email: String, fullName: String, age: Int, gender: String, phoneNumber: String) {
        self.email = email
        self.fullName = fullName
        self.age = age
        self.gender = gender
        self.phoneNumber = phoneNumber
    }
}
