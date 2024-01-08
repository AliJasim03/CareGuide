//
//  CreateHLTableViewController.swift
//  CareGuide
//
//  Created by mobileProg on 20/12/2023.
//

import UIKit
import Photos

class CreateHLTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //    var hospitalsArray : [Hospital] = []
    //    var labsArray : [Hospital] = []
    //    var hls: [Hospital] { return hospitalsArray + labsArray }
    
    var selectedHospital: Hospital?
    var editMode : Bool = false
    var is247: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission()
        checkReg()
        
        self.progressBar.setProgress(0, animated: false)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    var selectedTime: String?
    var selectedHospitalIndex: Int?
    var aBuilding: Hospital?
    
    @IBOutlet weak var hlNameField: UITextField!
    
    @IBOutlet weak var hlEmailField: UITextField!
    
    @IBOutlet weak var hlPasswordField: UITextField!
    
    @IBOutlet weak var hlPhoneField: UITextField!
    
    @IBOutlet weak var hlLocationField: UITextField!
    
    @IBOutlet weak var TimeSelectedLabel: UILabel!
    
    @IBOutlet weak var logoBtn: UIButton!
    @IBOutlet weak var isLabSwitch: UISwitch!
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    
    @IBAction func isLabChanged(_ sender: Any) {
        if !editMode{
            if isLabSwitch.isOn {
                self.navigationItem.title = "Add Lab"
            }else{
                self.navigationItem.title = "Add Hospital"
            }
        }else {
            if isLabSwitch.isOn {
                self.navigationItem.title = "Edit Lab"
            }else{
                self.navigationItem.title = "Edit Hospital"
            }
        }
        
    }
    
    
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            logoImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TimingSegue" {
            if let timeTableViewController = segue.destination as? TimeTableViewController {
                selectedTime = timeTableViewController.time
            }
        }else if segue.identifier == "backToView"{
            if let hospitalLabViewController = segue.destination as? HospitalLabViewController {
                hospitalLabViewController.selectedData = AppData.shared.hospitals
                hospitalLabViewController.tableView.reloadData()
            }
        }
    }
    
    
    //where to put this method code ? cellview?
    func updateHL(hl : Hospital){
        hlNameField.text = hl.name
        hlEmailField.text = hl.email
        hlPasswordField.text = hl.password
        hlPhoneField.text = hl.phoneNumber
        hlLocationField.text = hl.location
        TimeSelectedLabel.text = hl.timing
        selectedTime = hl.timing
        if let decodedData = Data(base64Encoded: hl.logo) {
            if let logoImage = UIImage(data: decodedData) {
                logoImageView.image = logoImage
            }
        }
        //timings
        //islab?
        // logoImageView.isHidden = hl.logo
    }
    
    // needs ajusdments after creating cell view THE CELL NAME
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //       // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    //
    //        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.hlCell.rawValue, for: indexPath) as! HLTableViewCell
    //        let hl = hls[indexPath.row]
    //        cell.updateHL(hl : hl)
    //        return cell
    //    }
    
    
    
    @IBAction func updateProgressBar(_ sender: UITextField) {
        let ratio : Float = 1/5
        var progress:Float = 0
        
        
        if (hlNameField.text ?? "").count >= 3{
            progress += ratio
        }else{
            let nameAlert =   UIAlertController(title: "Invalid Name ", message: "Please enter valid name", preferredStyle: .alert)
            nameAlert.addAction(UIAlertAction(title: "OK", style: .default))
        }
        
        if (hlEmailField.text ?? "").contains("@") && (hlEmailField.text ?? "").count >= 6{
            progress += ratio
        }else{
            let emailAlert =   UIAlertController(title: "Invalid Email ", message: "Please enter valid email", preferredStyle: .alert)
            emailAlert.addAction(UIAlertAction(title: "OK", style: .default))
        }
        
        if (hlPhoneField.text ?? "").count == 8 || ((hlPhoneField.text ?? "").count >= 8 && (hlPhoneField.text ?? "").filter({ $0 == "+" }).count == 1) {
            progress += ratio
        }else{
            let phoneAlert =   UIAlertController(title: "Invalid Phone ", message: "Please enter valid phone", preferredStyle: .alert)
            phoneAlert.addAction(UIAlertAction(title: "OK", style: .default))
        }
        if (hlPasswordField.text ?? "").count >= 8 {
            progress += ratio
        }else{
            let passwordAlert =   UIAlertController(title: "Invalid Password ", message: "Please enter valid password", preferredStyle: .alert)
            passwordAlert.addAction(UIAlertAction(title: "OK", style: .default))
        }
        if (hlLocationField.text ?? "").count >= 5{
            progress += ratio
        }
        else{
            let locationAlert =   UIAlertController(title: "Invalid Location ", message: "Please enter valid Location", preferredStyle: .alert)
            locationAlert.addAction(UIAlertAction(title: "OK", style: .default))
        }
        progressBar.setProgress(Float(progress), animated: true)
        checkReg()
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
    
    
    @IBAction func doneBtnPressed(_ sender: Any) {

        guard let aName = hlNameField.text,
              let aPassword = hlPasswordField.text,
              let aEmail = hlEmailField.text,
              let aPhone = hlPhoneField.text,
              let aLocation = hlLocationField.text,
              let aTiming = selectedTime
                
        else
        {
            return
        }
        if let aLogo = logoImageView.image, let logoData = aLogo.jpegData(compressionQuality: 1) {
            let logoBase64 = logoData.base64EncodedString()
            if !editMode{
                DataBase.db.createHospital(self, email: aEmail, password: aPassword, completion: { uid, error in
                    guard let uid = uid, error == nil else {
                        // Handle error
                        return
                    }
                    self.aBuilding = Hospital(name: aName, location: aLocation, timing:aTiming, is247: self.is247, password: aPassword, phoneNumber: aPhone, email: aEmail, isLab: self.isLabSwitch.isOn, logo: logoBase64, uid: uid)
                    
                    
                    if let aBuilding = self.aBuilding {
                        print("saved to local file, and db")
                        AppData.shared.hospitals.append(aBuilding)
                        AppData.shared.saveToFile()
                        DataBase.db.saveHopsital(hospital: aBuilding)
                        let successAlert = UIAlertController(title: "Account Created", message: "Account Created Successfully", preferredStyle: .alert)
                        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            self.performSegue(withIdentifier: "backToView", sender: self)
                        }))
                        self.present(successAlert, animated: true, completion: {
                            self.performSegue(withIdentifier: "backToView", sender: self)
                        })
                        self.performSegue(withIdentifier: "backToView", sender: self)
                        
                        
                    }
                    
                }) }else if editMode  {
                    // Edit the selected hospital
                    self.aBuilding = Hospital(name: aName, location: aLocation, timing:aTiming, is247: self.is247, password: aPassword, phoneNumber: aPhone, email: aEmail, isLab: self.isLabSwitch.isOn, logo: logoBase64, uid: selectedHospital!.uid)
                    
                    AppData.shared.hospitals[selectedHospitalIndex ?? -1] = aBuilding!
                    AppData.shared.saveToFile()
                    DataBase.db.saveHopsital(hospital: aBuilding!)
                    let successAlert = UIAlertController(title: "Account Updated", message: "Account Updated Successfully", preferredStyle: .alert)
                    successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.performSegue(withIdentifier: "backToView", sender: self)
                    }))
                    self.present(successAlert, animated: true, completion: {
                        self.performSegue(withIdentifier: "backToView", sender: self)
                    })
                    self.performSegue(withIdentifier: "backToView", sender: self)
                }
            
        } else {
            return
        }
        
        
        
        
    }
    
    
    func checkReg(){
        if progressBar.progress == 1.0{
            doneBtn.isEnabled = true
        }else{
            doneBtn.isEnabled = false
        }
    }
    
    @IBAction func unwindToCreateScreen(segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedTime = self.selectedTime{
            TimeSelectedLabel.text = selectedTime
        }
        if let selectedHospital = self.selectedHospital{
            updateHL(hl: selectedHospital)
            updateProgressBar(UITextField())
             selectedHospitalIndex = AppData.shared.hospitals.firstIndex(where: { $0 == self.selectedHospital })
        
        }
        
    }
}
