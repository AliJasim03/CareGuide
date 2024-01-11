//
//  HomePatientViewController.swift
//  CareGuide
//
//  Created by Lui on 10/01/2024.
//

import UIKit

class HomePatientViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    struct Hospital {
            var name: String
            var location: String
            var timing: String
            var password: String
            var phoneNumber: String
            var email: String
            var isLab : String
            var logo : String
    }
    
    struct Lab{
        let name: String
        let location: String
        let timing: String
        let password: String
        let phoneNumber: String
        let email: String
        let isLab: String
        let logo: String
    }
    
    
    
    var hospitals: [Hospital] = []
    var labs: [Lab] = []
    var selectedData: [Any] = []
    

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        hospitals = [
            Hospital(name: "Al-Salam Specialist Hospital", location: "Riffa", timing: "Open 24 hours", password: "passwordA", phoneNumber: "1234567890", email: "hospitalA@example.com", isLab: "false", logo: "ALSALAMIMG"),
            Hospital(name: "Al Hilal Hospital", location: "Muharraq", timing: "Open 24 hours", password: "passwordB", phoneNumber: "9876543210", email: "hospitalB@example.com", isLab: "false", logo: "AlHilalIMG"),
            Hospital(name: "King Hamad University Hospital", location: "Al Sayh", timing: "Open 24 hours", password: "passwordC", phoneNumber: "5555555555", email: "hospitalC@example.com", isLab: "false", logo: "KHUIMG"),
        ]
        
        labs = [
            Lab(name: "Thyrocare Gulf LAB W.L.L", location: "Isa Town", timing: "7:00 AM - 3:00 PM", password: "passwordA", phoneNumber: "1111111111", email: "labA@example.com", isLab: "true", logo: "thyrocareIMG"),
            Lab(name: "Al-Borg Medical Laboratory", location: "Busaiteen", timing: "8:00 AM - 9:00 PM", password: "passwordB", phoneNumber: "2222222222", email: "labB@example.com", isLab: "true", logo: "AlBorgIMG"),
            Lab(name: "Bahrain Medical Laboratory", location: "Manama", timing: "7:30 AM - 9:00 PM", password: "passwordC", phoneNumber: "3333333333", email: "labC@example.com", isLab: "true", logo: "BMLIMG"),
        ]
        
        // Initially set selectedData to hospitals and configure the table view
        
        selectedData = hospitals
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.isEditing = false
    
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        // Update selectedData based on the selected segment
        if sender.selectedSegmentIndex == 0 {
            selectedData = hospitals
        } else if sender.selectedSegmentIndex == 1 {
            selectedData = labs
        } else if sender.selectedSegmentIndex == 2 {
            selectedData = labs + hospitals
        }
        // Reload the table view with the updated data
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedData.count
    }
    
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
            cell.TimingsLbl.text = "Hours: \(data.timing)"
            // Set the common image for both hospitals and labs
            cell.Img1.image = UIImage(named: data.logo)
        } else if let data = selectedData[indexPath.row] as? Lab {
            cell.nameLabel.text = data.name
            cell.locationLabel.text = "Location: \(data.location)"
            cell.TimingsLbl.text = "Hours: \(data.timing)"
            // Set the common image for both hospitals and labs
            cell.Img1.image = UIImage(named: data.logo)
        }
        
        // Return the configured cell
        return cell
    }
    
    
    

    
    
}
