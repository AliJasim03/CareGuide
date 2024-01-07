//
//  HHViewViewController.swift
//  CareGuide
//
//  Created by Fatima Moh'd on 06/01/2024.
//

import UIKit

class HHViewViewController: UIViewController {
    
    var database: DataBase?
    var selectedUser: User?
    var selectedBooking: Booking?
    var selectedIndexPath: IndexPath?
    
    
    @IBOutlet weak var CompleteButton: UIBarButtonItem!
    
    @IBOutlet weak var Namelbl: UILabel!
    @IBOutlet weak var doblbl: UILabel!
    @IBOutlet weak var Datelbl: UILabel!
    @IBOutlet weak var Emaillbl: UILabel!
    @IBOutlet weak var Phonelbl: UILabel!
    @IBOutlet weak var Packagenamelbl: UILabel!
    @IBOutlet weak var includeslbl: UILabel!
    @IBOutlet weak var Pricelbl: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = DataBase.createInstance()
        database?.addSampleDataIfNeeded()
        
        
        selectedUser = database?.getUser()
        selectedBooking = database?.getBooking()
        
        
        configure(with: selectedUser, and: selectedBooking)
        
        //CompleteButton.addTarget(self, action: #selector(completeButtonPressed), for: .touchUpInside)
    }
    
    func completeBooking(at indexPath: IndexPath) {
            guard let selectedBooking = selectedBooking else {
                return
            }

            selectedBooking.status = .compleleted
            updateUI()

            // Notify the delegate or use any other method to communicate the completion to HHistoryTableViewController
        }

        func updateUI() {
            // Perform any UI updates if needed
        }
    
    
    func configure(with user: User?, and booking: Booking?) {
        if let user = user {
            Namelbl.text = user.fullName
            Phonelbl.text = user.phoneNumber
            doblbl.text = user.dateOfBirth
            Emaillbl.text = user.email
        }
        
        if let booking = booking {
            //Pricelbl.text = booking.price
            Datelbl.text = booking.date
        }
    }
  
}
    
   // @IBAction func completeButtonPressed(_ sender: Any) {
       
        
        //let alert = UIAlertController(title: "Complete Booking", message: "Are you sure you want to mark this booking as completed?", preferredStyle: .alert)
        
        // Add a cancel action
        //alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add a confirm action
       // alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
           // self?.updateUI()
          //  self?.dismiss(animated: true, completion: nil)
     //   }))
        
        // Present the alert
        //present(alert, animated: true, completion: nil)
   // }
//}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


