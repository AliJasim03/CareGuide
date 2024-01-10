//
//  HHViewViewController.swift
//  CareGuide
//
//  Created by Fatima Moh'd on 06/01/2024.
//

import UIKit

class HHViewViewController: UIViewController{
    // Properties to store data
    var database: DataBase?
    var selectedUser: User?
    var selectedBooking: Booking?
    var selectedIndexPath: IndexPath?
    
    
    @IBOutlet weak var Namelbl: UILabel!
    @IBOutlet weak var doblbl: UILabel!
    @IBOutlet weak var Datelbl: UILabel!
    @IBOutlet weak var Emaillbl: UILabel!
    @IBOutlet weak var Phonelbl: UILabel!
    @IBOutlet weak var Packagenamelbl: UILabel!
    @IBOutlet weak var includeslbl: UILabel!
    @IBOutlet weak var Pricelbl: UILabel!
    
    
    
    @IBOutlet var tableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set selectedUser based on the patient from selectedBooking
        if let patient = selectedBooking?.patient {
                    selectedUser = patient
                }
        // Configure UI with selectedUser and selectedBooking
                configure(with: selectedUser, and: selectedBooking)
            }
    
    
    func configure(with user: User?, and booking: Booking?) {
        if let user = user {
            Namelbl.text = user.fullName
            Phonelbl.text = user.phoneNumber
            doblbl.text = user.dateOfBirth
            Emaillbl.text = user.email
        }
        
        if let booking = booking {
            Packagenamelbl.text = booking.testType
            Datelbl.text = booking.date
            Pricelbl.text = booking.price
            includeslbl.text = booking.include
        }
        
    }
    
}
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


