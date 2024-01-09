//
//  Data.swift
//  CareGuide
//
//  Created by Ali Jasim on 07/01/2024.
//

import Foundation

class AppData {
  static let shared = AppData()
  var hospitals = [Hospital]()

  private init() {
      loadHospitalsFromFile()
  }

  public func loadHospitalsFromFile() {
      let decoder = PropertyListDecoder()
      if let data = try? Data(contentsOf: fileHopspitalsURL()),
         let decodedHospitals = try? decoder.decode([Hospital].self, from: data) {
          hospitals = decodedHospitals
      }else {
          hospitals = [
//                 Hospital(name: "Al-Salam Specialist Hospital", location: "Riffa", timing: "Open 24 hours", password: "passwordA", phoneNumber: "1234567890", email: "hospitalA@@example.com", isLab: false, logo: "ALSALAMIMG"),
//                 Hospital(name: "Al Hilal Hospital", location: "Muharraq", timing: "Open 24 hours", password: "passwordB", phoneNumber: "9876543210", email: "hospitalB@example.com", isLab: false, logo: "AlHilalIMG"),
//                 Hospital(name: "King Hamad University Hospital", location: "Al Sayh", timing: "Open 24 hours", password: "passwordC", phoneNumber: "5555555555", email: "hospitalC@example.com", isLab: false, logo: "KHUIMG"),
//                 Hospital(name: "Thyrocare Gulf LAB W.L.L", location: "Isa Town", timing: "7:00 AM - 3:00 PM", password: "passwordA", phoneNumber: "1111111111", email: "labA@example.com", isLab: true, logo: "thyrocareIMG"),
//                 Hospital(name: "Al-Borg Medical Laboratory", location: "Busaiteen", timing: "8:00 AM - 9:00 PM", password: "passwordB", phoneNumber: "2222222222", email: "labB@example.com", isLab: true, logo: "AlBorgIMG"),
//                 Hospital(name: "Bahrain Medical Laboratory", location: "Manama", timing: "7:30 AM - 9:00 PM", password: "passwordC", phoneNumber: "3333333333", email: "labC@example.com", isLab: true, logo: "BMLIMG"),
             ]
      }
  }

   func saveToFile() {
      let encoder = PropertyListEncoder()
      if let encoded = try? encoder.encode(hospitals) {
          do {
              try encoded.write(to: fileHopspitalsURL())
              print("Successfully wrote to file!")
          } catch {
              print("Error writing to file: \(error)")
          }
      }
  }

  private func fileHopspitalsURL() -> URL {
      let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let fileName = "hospitals.plist"
      return documentsUrl.appendingPathComponent(fileName)
  }

}


 
