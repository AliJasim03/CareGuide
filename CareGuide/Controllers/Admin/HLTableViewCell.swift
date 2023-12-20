//
//  HLTableViewCell.swift
//  CareGuide
//
//  Created by mobileProg on 20/12/2023.
//

import UIKit

class HLTableViewCell: UITableViewCell {

    //add labels for hospital details here and connect them
    
    //updating the editing
    // it will not be red after connecting it
    func updateHL(hl : Hospital){
        hlNameField.text = hl.name
        hlEmailField.text = hl.email
        hlPhoneField.text = hl.phoneNumber
        hlLocationField.text = hl.location
        //timings
        //logo
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
