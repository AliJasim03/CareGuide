//
//  MedicalPackageTableViewCell.swift
//  CareGuide
//
//  Created by Rashed Albuainain on 04/01/2024.
//

import UIKit

class MedicalPackageTableViewCell: UITableViewCell {
    @IBOutlet weak var packageNameLabel: UILabel!

    @IBOutlet weak var packageExpirationDateLabel: UILabel!
    
    @IBOutlet weak var packageNumberOfTestLabel: UILabel!
    
    @IBOutlet weak var packagePriceLabel: UILabel!
    
    func configure(medicalpackage: medicalpackage){
        packageNameLabel.text = medicalpackage.medicalPackageName
        packageExpirationDateLabel.text = medicalpackage.medicalPackageExperationDate
        if let numberOfTests = medicalpackage.medicalPackageNumberOfTests.first {
                packageNumberOfTestLabel.text = String(numberOfTests)
            } else {
                packageNumberOfTestLabel.text = nil
            }
            
            packagePriceLabel.text = String(medicalpackage.medicalPackagePrice)
    }
    
    func configureTest(medicaltest : medicalTest) {

        
    }
    
    
    
}
