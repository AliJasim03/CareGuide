//
//  TimeTableViewController.swift
//  CareGuide
//
//  Created by mac on 23/12/2023.
//

import UIKit

class TimeTableViewController: UITableViewController {
//needs a choice after running and testing
    var time : String? = ""
    
    @IBOutlet weak var fromTimePicker: UIDatePicker!
    
    @IBOutlet weak var toTimePicker: UIDatePicker!

    //constraint needed for txt fields
    @IBOutlet weak var toTimeTxtField: UITextField!
    
    
    @IBOutlet weak var fromTimeTxtField: UITextField!
    
    @IBOutlet weak var fullTimeSwitch: UISwitch!
    
    //which method?
    
    @IBAction func switchStatus(_ sender: UISwitch){
               
        if sender.isOn {
            time = "24 Hours"
            toTimePicker.isEnabled = false
            fromTimePicker.isEnabled = false
            
        }else{
            toTimePicker.isEnabled = true
            fromTimePicker.isEnabled = true
            time = (fromTimeTxtField.text ?? "") + ("") + (toTimeTxtField.text ?? "")
        }
    }
    

    
    //fromTimeFunc
    func fromTimePick(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil /*self*/, action: #selector(fromDoneBtnPressed))
                                      
        toolBar.setItems([doneBtn], animated: true)
        
        
        fromTimePicker.datePickerMode = .time
        //assign the toolbar
        
        fromTimeTxtField.inputAccessoryView = toolBar
        
        // assign time picker to the text field
        fromTimeTxtField.inputView = fromTimePicker
        
    }
    @objc func fromDoneBtnPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        fromTimeTxtField.text = dateFormatter.string(from: fromTimePicker.date)
        self.view.endEditing(true)
        
        /* or only this
        fromTimeTxtField.text = "\(fromTimePicker.timeZone)" //timeZone?
        self.view.endEditing(true)
         */
    }
    
    
    
    
    
    //toTime func
    
    func toTimePick(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil /*self? */, action: #selector(toDoneBtnPressed))
                                      
        toolBar.setItems([doneBtn], animated: true)
        
        
        toTimePicker.datePickerMode = .time
        //assign the toolbar
        
        toTimeTxtField.inputAccessoryView = toolBar
        
        // assign time picker to the text field
        toTimeTxtField.inputView = toTimePicker
        
    }
    @objc func toDoneBtnPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        toTimeTxtField.text = dateFormatter.string(from: toTimePicker.date)
        self.view.endEditing(true)
        
        /*or only this
        toTimeTxtField.text = "\(toTimePicker.timeZone)" //timeZone?
        self.view.endEditing(true)
         */
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       /* let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        
        let fTime = UIDatePicker()
        fTime.datePickerMode = .time
        fTime.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        
       // fTime.inputView = fTime
        
        */
    }
        
       /* @objc func timePickerValueChanged(sender : UIDatePicker){
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_gb")
            formatter.dateFormat = "HH:mm"
        }
        */
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
