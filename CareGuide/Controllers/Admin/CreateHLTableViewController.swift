//
//  CreateHLTableViewController.swift
//  CareGuide
//
//  Created by mobileProg on 20/12/2023.
//

import UIKit
import Photos

class CreateHLTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var hls: [Hospital] = []

    struct PropertyKeys {
        //static let unwind = "UnwindToCreatHL" used down important
        static let creatHL = "createHLSegue"
      //  static let editHL = ""
    }
    var selectedTime: String?
    
    var aBuilding: Hospital?
    
    @IBOutlet weak var hlNameField: UITextField!
    
    @IBOutlet weak var hlEmailField: UITextField!
    
    @IBOutlet weak var hlPasswordField: UITextField!
    
    @IBOutlet weak var hlPhoneField: UITextField!
    
    @IBOutlet weak var hlLocationField: UITextField!
    
        
    @IBOutlet weak var logoBtn: UIButton!
    @IBOutlet weak var isLabSwitch: UISwitch!
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    
    
    
    @IBAction func logoAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: . actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler : {
            (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else {
             let cameraAlert =   UIAlertController(title: "Camera not found", message: "Check camera access", preferredStyle: .alert)
                cameraAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler : {
            (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
                                           ))
        self.present(actionSheet, animated: true, completion: nil)
    }
    //error waiting for run
/*    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        logoImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
} */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
        
    @IBAction func doneCreating(_ sender: Any) {
        guard let aName = hlNameField.text,
              let aPassword = hlPasswordField.text,
              let aEmail = hlEmailField.text,
              let aPhone = hlPhoneField.text,
              let aLocation = hlLocationField.text,
              let aTiming = selectedTime,
              let aLogo = logoImageView.image
            
        
              else
        {
            return
        }
            aBuilding = Hospital(name: aName, location: aLocation, timing: aTiming, password: aPassword, phoneNumber: aPhone, email: aEmail, isLab: isLabSwitch.isOn,  logo: aLogo)
      
                //performSegue for unwindd
       // performSegue(withIdentifier: PropertyKeys.unwind, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TimingSegue" {
            if let timeTableViewController = segue.destination as? TimeTableViewController {
                selectedTime = timeTableViewController.time
                    
                
            }
        }
    }
    
    
    
    //where to put this method code ? cellview?
    func updateHL(hl : Hospital){
        hlNameField.text = hl.name
        hlEmailField.text = hl.email
        hlPhoneField.text = hl.phoneNumber
        hlLocationField.text = hl.location
        //timings
        
        //islab?
        
       // logoImageView.isHidden = hl.logo
        
    }
   // needs ajusdments after creating cell view THE CELL NAME
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.hlCell.rawValue, for: indexPath) as! HLTableViewCell
        let hl = hls[indexPath.row]
        cell.updateHL(hl : hl)
        return cell
    }

    func checkPermission(){
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({(status: PHAuthorizationStatus) -> Void in () })
        }
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            
        }else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    func requestAuthorizationHandler(status : PHAuthorizationStatus){
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("Access granted to use Photo Library")
        } else {
            print("We do not have access to your photos")
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
checkPermission()
        
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
