//
//  HospitalsHomePageTableViewController.swift
//  CareGuide
//
//  Created by Rashed Albuainain on 09/01/2024.
//

import UIKit
import FirebaseAuth
//viewPTCell
class HospitalsHomePageTableViewController: UITableViewController {
    var selectedSegmentIndex = 0
    var data: [Any] = [] // An array to store tests and packages
    
    var tests: [Test] = []
    var packages: [Package] = []
    
    
    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var ptName: UILabel!
    @IBOutlet weak var ptExpirationDate: UILabel!
    @IBOutlet weak var ptNumberOfTest: UILabel!
    @IBOutlet weak var ptPrice: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "viewPTCell")
        tableView.tableFooterView = UIView()
        segmentedControl.addTarget(self, action: #selector(SegmentController(_:)), for: .valueChanged)
        
   
    }
    override func viewWillAppear(_ animated: Bool) {
        if let loadedArrays = loadArrays() {
            tests = loadedArrays.0
            packages = loadedArrays.1
        }
        tableView.reloadData()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Only one section for displaying saved packages
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegmentIndex == 0{
            return packages.count
        }else {
            return tests.count
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewPTCell", for: indexPath)
        if selectedSegmentIndex == 0{
            cell.textLabel?.text = packages[indexPath.row].name
        }else {
            cell.textLabel?.text = tests[indexPath.row].name
        }
        
        return cell
    }
    @IBAction func SegmentController(_ sender: UISegmentedControl) {
        // Update the selected index property
        selectedSegmentIndex = sender.selectedSegmentIndex
        
        // Reload the table view to reflect the changes
        tableView.reloadData()
    }
    // ... other code ...
    
    // Function to add a saved package to the array and reload the table view
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Create an alert controller for confirmation
            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            // Add actions to the alert controller
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                // Remove the item from the data source (selectedData)
                
                if self.selectedSegmentIndex ==  0{
                    self.packages.remove(at: indexPath.row)
                }else{
                    self.tests.remove(at: indexPath.row)
                }
                
                
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
    // ... other code ...
    @IBAction func signOutTappedButton(_ sender: Any) {
        do{
            try FirebaseAuth.Auth.auth().signOut()
        } catch {
            print("Error Signing out")
        }
        UserDefaults.standard.removeObject(forKey: "hospital_uid_key")
        UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(
            name: "Main",
            bundle: nil
        )
        let newVc = storyboard.instantiateViewController(withIdentifier: "Main")
        self.view.window!.rootViewController = newVc
    }
}

struct Test: Codable {
    var name: String
    var price: Double
    var description: String
}

struct Package: Codable {
    var name: String
    var price: Double
    var description: String
    var tests: [Test]
}
func loadArrays() -> ([Test], [Package])? {
    if let savedData1 = UserDefaults.standard.data(forKey: "TestsKey"),
       let savedData2 = UserDefaults.standard.data(forKey: "PackagesKey"),
       let loadedArray1 = try? JSONDecoder().decode([Test].self, from: savedData1),
       let loadedArray2 = try? JSONDecoder().decode([Package].self, from: savedData2) {
        return (loadedArray1, loadedArray2)
    }
    return nil
}
