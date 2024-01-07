//
//  HospitalBookingsTableViewCell.swift
//  CareGuide
//
//  Created by Fatima Moh'd on 06/01/2024.
//

import UIKit

class HospitalBookingsTableViewCell: UITableViewCell {

    @IBOutlet weak var Statuslbl: UILabel!
        @IBOutlet weak var Testlbl: UILabel!
        @IBOutlet weak var Pricelbl: UILabel!
        @IBOutlet weak var Datelbl: UILabel!
        
    @IBOutlet weak var patientlbl: UILabel!
    
        func configure(booking: Booking){
            Statuslbl.text = "i"
            patientlbl.text = booking.patient
            Testlbl.text = booking.testType
            Pricelbl.text = booking.price
            Datelbl.text = booking.date
            
                    switch booking.status {
                    case .upcoming:
                        Statuslbl.text = "Upcoming"
                        
                    case .compleleted:
                        Statuslbl.text = "Completed"
                        
                    case .cancelled:
                        Statuslbl.text = "Cancelled"
                       
                    }
            
        
            
            
        }
        }
