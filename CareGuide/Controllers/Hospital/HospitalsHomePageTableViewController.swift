//
//  HospitalsHomePageTableViewController.swift
//  CareGuide
//
//  Created by Rashed Albuainain on 09/01/2024.
//

import UIKit
import FirebaseAuth

class HospitalsHomePageTableViewController: UITableViewController {
    var savedPackages: [String] = [] // Array to store saved packages
    
    @IBOutlet weak var ptName: UILabel!
    @IBOutlet weak var ptExpirationDate: UILabel!
    @IBOutlet weak var ptNumberOfTest: UILabel!
    @IBOutlet weak var ptPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Only one section for displaying saved packages
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPackages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = savedPackages[indexPath.row]
        return cell
    }
    
    // ... other code ...
    
    // Function to add a saved package to the array and reload the table view
    func addSavedPackage(package: String) {
        savedPackages.append(package)
        tableView.reloadData()
    }
    
    // ... other code ...
}
