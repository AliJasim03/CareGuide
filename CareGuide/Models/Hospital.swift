//
//  Hospital.swift
//  CareGuide
//
//  Created by Ali Jasim on 24/10/2023.
//

import Foundation
class Hospital {
    var logo: String
    var name: String
    var location: String
    var timing: String
    var description: String

    init(logo: String, name: String, location: String, timing: String, description: String) {
        self.logo = logo
        self.name = name
        self.location = location
        self.timing = timing
        self.description = description
    }
}
