//
//  PBookinghistoryTableViewController.swift
//  CareGuide
//
//  Created by mobileProg on 06/12/2023.
//

import UIKit

class PBookinghistoryTableViewController: UITableViewController {

    
    var bookings = DataBase.bookings
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return bookings.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.PBookingCell.rawValue, for: indexPath) as! PBookingHistoryTableViewCell
        
        let booking = bookings[indexPath.row]
        cell.configure(booking: booking)


        return cell
    }


   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Cancel Booking", message: "Are you sure you want to cancel this appointment?", preferredStyle: .alert)
            
            // Add a cancel action
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            // Add a confirm action
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
                // User confirmed, cancel the booking
                self?.cancelBooking(at: indexPath)
            }))
            
            // Present the alert
            present(alert, animated: true, completion: nil)
        }
    }
    
    func cancelBooking(at indexPath: IndexPath) {
        // Remove the booking from your data source
        bookings.remove(at: indexPath.row)
        // Assuming DataBase.bookings is your data source
        DataBase.bookings.remove(at: indexPath.row)
        
        // Delete the corresponding row from the table view
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Cancel"
    }
}

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


