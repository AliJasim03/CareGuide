//
// HospitalLabViewController.swift
// CareGuide
//
// Created by Hadi Alrahmani on 19/12/2023.


// This line imports the UIKit framework, which provides essential components for building iOS applications.
import UIKit

/* This line defines a Swift class named HospitalLabViewController that inherits from UIViewController and conforms to the UITableViewDataSource and UITableViewDelegate protocols. This means that instances of this class can be used as a view controller and will be responsible for providing data and handling events for a table view. */

class HospitalLabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Arrays to store data for hospitals, labs, and the currently selected data
    
    /* These lines declare three instance variables. hospitals and labs are arrays that will store instances of the Hospital and Lab classes, respectively. selectedData is an array that will be used to store the currently selected data, which could be either hospitals or labs.*/
    
    var hospitals: [Hospital] = AppData.shared.hospitals
    var selectedData: [Any] = []
    var selectedHospitalName: String?
    // Outlet for the UITableView in the storyboard
    
    /* This line declares an outlet for a UITableView named tableView. This outlet is connected to a table view in the storyboard, allowing the code to interact with and manipulate the table view. */
    
    @IBOutlet weak var tableView: UITableView!
    
    // This method is called when the view is loaded into memory
    /* The viewDidLoad method is an override of the superclass method. It is called when the view is loaded into memory. Here, it is used to set up sample data for hospitals and labs, set the initial value of selectedData to hospitals, and configure the table view. */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Sample data for hospitals and labs */
        
       
        // Initially set selectedData to hospitals and configure the table view
        
        selectedData = hospitals
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.isEditing = false
    }
    
    /* This method is called when the segmented control value changes */
    /* This method is an action associated with a segmented control. It is triggered when the segmented control's value changes. It updates selectedData based on the selected segment (0 for hospitals, 1 for labs) and reloads the table view to reflect the changes. */
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        // Update selectedData based on the selected segment
        if sender.selectedSegmentIndex == 0 {
            selectedData = hospitals
        } else if sender.selectedSegmentIndex == 1 {
            selectedData = hospitals.filter { $0.isLab == true }
        }
        // Reload the table view with the updated data
        tableView.reloadData()
    }
    
    /* UITableViewDataSource method to return the number of rows in the table view */
    /* This method is required by the UITableViewDataSource protocol and specifies the number of rows in the table view. It returns the count of elements in the selectedData array. */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedData.count
    }
    
    /* UITableViewDataSource method to configure and return cells for the table view */
    /* This method is also required by the UITableViewDataSource protocol and is responsible for configuring and returning cells for the table view. It dequeues a reusable cell with the identifier "CommonCell" and configures it based on the type of object in selectedData (Hospital or Lab). */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Attempt to dequeue a reusable cell with the identifier "CommonCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath) as? CommonCell else {
            // Return an empty cell if the dequeuing fails
            return UITableViewCell()
        }
        
        // Populate the cell with data based on the type of object in selectedData
        if let data = selectedData[indexPath.row] as? Hospital {
            cell.nameLabel.text = data.name
            cell.locationLabel.text = "Location: \(data.location)"
            cell.TimingsLbl.text = "Hours: \(data.timingFrom) - \(data.timingTo)"
            // Set the common image for both hospitals and labs
            cell.Img1.image = UIImage(named: data.logo)
        }
        
        
        // Return the configured cell
        return cell
    }

    /* UITableViewDelegate method to handle row deletion */
    /* This method is part of the UITableViewDelegate protocol and is responsible for handling row deletion. It presents an alert controller to confirm the deletion and performs the deletion action if the user confirms. */
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Create an alert controller for confirmation
            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            // Add actions to the alert controller
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                if let hospital = self.selectedData[indexPath.row] as? Hospital {
                    // Remove the hospital from the AppData singleton
                    AppData.shared.hospitals.removeAll(where: { $0 == hospital })
                    AppData.shared.saveToFile()
                }
                // Remove the item from the data source (selectedData)
                self.selectedData.remove(at: indexPath.row)
                
                // Update the table view with the new data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // Do nothing when cancel is pressed
            }
            
            // Add the actions to the alert controller
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            // Present the alert controller
            present(alertController, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let cell = tableView.cellForRow(at: indexPath) as? CommonCell {
           self.selectedHospitalName = cell.nameLabel.text

       }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "CreateHLSegue" {
           if let destinationVC = segue.destination as? CreateHLTableViewController {
               destinationVC.navigationItem.title = "Add Hospital/Label"
               print("Preparing for segue")

           }
           
       }else if segue.identifier == "EditHLSegue" {
           if let destinationVC = segue.destination as? CreateHLTableViewController,
                   let selectedHospitalName = selectedHospitalName,
                   let selectedHospital = hospitals.first(where: { $0.name == selectedHospitalName }) {
               destinationVC.navigationItem.title = "Edit Hospital/Label"
                    destinationVC.selectedHospital = selectedHospital
                }
       }
    }
    

}
