//
//  PBookingHistoryTableViewCell.swift
//  CareGuide
//
//  Created by mobileProg on 06/12/2023.
//

import UIKit

class PBookingHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var testTypeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var Locationlbl: UILabel!
    
    func configure(booking: Booking){
        statusLbl.text = "Hi"
        nameLbl.text = booking.name
        testTypeLbl.text = booking.testType
        dateLbl.text = booking.date
        Locationlbl.text = booking.location
    }
}
