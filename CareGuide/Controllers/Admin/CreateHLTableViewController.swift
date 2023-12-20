//
//  CreateHLTableViewController.swift
//  CareGuide
//
//  Created by mobileProg on 20/12/2023.
//

import UIKit

class CreateHLTableViewController: UITableViewController {
    struct PropertyKeys {
        static let unwind = "UnwindToCreatHL"
    }
    var hospital: Hospital?
    
    @IBOutlet weak var hlNameField: UITextField!
    
    @IBOutlet weak var hlEmailField: UITextField!
    
    @IBOutlet weak var hlPasswordField: UITextField!
    
    @IBOutlet weak var hlPhoneField: UITextField!
    
    @IBOutlet weak var hlLocationField: UITextField!
    
    
    @IBOutlet weak var isLabSwitch: UISwitch!
    
    @IBAction func doneCreating(_ sender: Any) {
        guard let aName = hlNameField.text,
              let aPassword = hlPasswordField,
        let aEmail = hlEmailField.text,
              let aPhone = hlPhoneField.text,
              let aLocation = hlLocationField.text
              //let timing =
              //let logo =
              
        aBuilding = Hospital(logo: <#T##String#>, name: aName, location: aLocation, timing: a, password: aPassword, phoneNumber: aPhone, email: aEmail)
    }
    
    //put this method code in the cell view when it is created please
    func updateHL(hl : Hospital){
        hlNameField.text = hl.name
        hlEmailField.text = hl.email
        hlPhoneField.text = hl.phoneNumber
        hlLocationField.text = hl.location
        //timings
        //logo
        
    }
    //needs ajusdments after creating cell view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.hlCell, for: indexPath) as! HLViewCell
        let hl = Hospitals[indexPath.row]
        cell.update(hl : hl)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    } */

   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    

}
