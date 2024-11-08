//
//  HHistoryTableViewController.swift
//  CareGuide
//
//  Created by Fatima Moh'd on 25/12/2023.
//

import UIKit

class HHistoryTableViewController: UITableViewController {
    
    // Properties to store data
    var selectedBooking: Booking?
    var bookings = DataBase.bookings
    var filteredBookings = [Booking]()
    
    
    // Outlet for segmented control
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        filterBookings()
        tableView.reloadData()
        
        

        }

    // Method to set up the segmented control
    func setupSegmentedControl() {
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
    }
    // Action when the value of segmented control changes
    @objc func segmentControlValueChanged() {
        filterBookings()
        tableView.reloadData()
    }
    
    // Method to filter bookings based on the selected segment
    func filterBookings() {
        let selectedSegmentIndex = segmentControl.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            // All bookings
            filteredBookings = bookings
        case 1:
            // Upcoming bookings
            filteredBookings = bookings.filter { $0.status == .upcoming }
        case 2:
            // Completed bookings
            filteredBookings = bookings.filter { $0.status == .compleleted }
        case 3:
            // Canceled bookings
            filteredBookings = bookings.filter { $0.status == .cancelled }
        default:
            break
        }
        tableView.reloadData()  // Add this line to refresh the table view after filtering
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130.0
    }
    // MARK: - Table view data source
    // Override to set the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return bookings.count
        } else {
            return filteredBookings.count
        }
    }
    
    
   
    // Override to set up the content of each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.HBookingCell.rawValue, for: indexPath) as! HospitalBookingsTableViewCell
        // Determine the booking object for the current row based on the selected segment
        let booking: Booking
        if segmentControl.selectedSegmentIndex == UISegmentedControl.noSegment {
            booking = bookings[indexPath.row]
        } else {
            booking = filteredBookings[indexPath.row]
        }
        
        cell.configure(booking: booking)
        
        return cell
    }
    // Override to handle row selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedBooking = segmentControl.selectedSegmentIndex == 0 ? bookings[indexPath.row] : filteredBookings[indexPath.row]
        performSegue(withIdentifier: "ViewSegue", sender: selectedBooking)
    }

    // Override to prepare for the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ViewSegue" {
                if let destinationVC = segue.destination as? HHViewViewController,
                   let selectedBooking = sender as? Booking {
                    destinationVC.selectedBooking = selectedBooking
                }
            }
        }

    
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    // Method to mark a booking as completed
    func moveBookingToCompleted(at indexPath: IndexPath) {
        let selectedBooking = segmentControl.selectedSegmentIndex == 0 ? bookings[indexPath.row] : filteredBookings[indexPath.row]
        selectedBooking.status = .compleleted

        // Reload the data and refresh the table view
        tableView.reloadData()

        // switch to the "Completed" segment
        segmentControl.selectedSegmentIndex = 2
        filterBookings()
        tableView.reloadData()
    }
    
    func cancelBooking(at indexPath: IndexPath) {
        
        let selectedBooking = segmentControl.selectedSegmentIndex == 0 ? bookings[indexPath.row] : filteredBookings[indexPath.row]
        selectedBooking.status = .cancelled

        // Reload the data and refresh the table view
        tableView.reloadData()

        // switch to the "Cancelled" segment
        segmentControl.selectedSegmentIndex = 3
        filterBookings()
        tableView.reloadData()
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let completeAction = UIContextualAction(style: .normal, title: "Complete") { [weak self] (_, _, completionHandler) in
                self?.moveBookingToCompleted(at: indexPath)
                completionHandler(true)
            }

            completeAction.backgroundColor = .systemGreen

            return UISwipeActionsConfiguration(actions: [completeAction])
        }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Cancel") { [weak self] (_, _, completionHandler) in
            self?.cancelBooking(at: indexPath)
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func completeBooking(at indexPath: IndexPath) {
            let alert = UIAlertController(title: "Complete Booking", message: "Are you sure you want to mark this booking as completed?", preferredStyle: .alert)

            // Add a cancel action
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            // Add a confirm action
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
                self?.selectedBooking?.status = .compleleted
                self?.completeBooking(at: indexPath)
                self?.tableView.reloadData()
            }))

            // Present the alert on the main thread
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }

    func showCancelAlert(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Cancel Booking", message: "Are you sure you want to cancel this booking?", preferredStyle: .alert)

        // Add a cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Add a confirm action
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
            self?.cancelBooking(at: indexPath)
        }))

        // Present the alert on the main thread
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
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


