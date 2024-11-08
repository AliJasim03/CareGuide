//
//  SignUpTableViewController.swift
//  CareGuide
//
//  Created by Ali Jasim on 09/10/2023.
//

import UIKit

class SignUpTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    @IBOutlet weak var ageDatePicker: UIDatePicker!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressBar.setProgress(0, animated: false)
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for cell in tableView.visibleCells {
            for subview in cell.contentView.subviews {
                setBorderColor(for: subview)
            }
        }
    }

    func setBorderColor(for view: UIView) {
        if let textField = view as? UITextField {
            textField.layer.borderWidth = 0.6
            textField.layer.cornerRadius = 10
            textField.layer.borderColor = UIColor(red: 23/255, green: 70/255, blue: 102/255, alpha: 1).cgColor
            textField.clipsToBounds = true
            let color = UIColor(red: 136/255, green: 160/255, blue: 184/255, alpha: 1)

            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [.foregroundColor: color])
            textField.textColor = UIColor(red: 23/255, green: 70/255, blue: 102/255, alpha: 1)

        } else {
            for subview in view.subviews {
                setBorderColor(for: subview)
            }
        }
    }

    // Remove the section hieght and the content inside it
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func checkRegistraion() -> Bool{
        let valid = Helper.shared.wrapTextFields(textFields: [nameTextField,emailTextField,phoneTextField,passwordTextField,confirmPasswordTextField])

        guard valid && progressBar.progress == 1.0 else{
            Helper.shared.showAlert(Controller: self, title: "Invalid Registration Form", message: "Please fill your registraoin form")
            return false
        }
        guard progressBar.progress == 1.0 else{
            Helper.shared.showAlert(Controller: self, title: "Invalid Registration Form", message: "Please Check your text fields input")
            return false
        }
        
        return true
    }
    
    var previousSender: UITextField = UITextField()
    @IBAction func updateProgressBar(_ sender: UITextField) {
        let ratio : Float = 1/5
        var progress:Float = 0
    
        
        if (nameTextField.text ?? "").count >= 3{
                progress += ratio
            }
            
            if (emailTextField.text ?? "").contains("@") && (emailTextField.text ?? "").count >= 6{
                progress += ratio
            }
        
            if (phoneTextField.text ?? "").count == 8 || ((phoneTextField.text ?? "").count >= 8 && (phoneTextField.text ?? "").filter({ $0 == "+" }).count == 1) {
                progress += ratio
            }
            if (passwordTextField.text ?? "").count >= 6 {
                progress += ratio
            }
            if (confirmPasswordTextField.text ?? "") == passwordTextField.text ?? "" && (passwordTextField.text ?? "").count >= 6{
                progress += ratio
            }
        
        progressBar.setProgress(Float(progress), animated: true)
    }


    @IBAction func signUpButtonTapped(_ sender: Any) {
        let valid = checkRegistraion
        guard valid() else{return}
        DataBase.db.createUser(self, email: emailTextField.text!, password: passwordTextField.text!, completion: { [self] error in if error != nil {print(error ?? "")
            return}
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            DataBase.db.saveUserData(user: User(email: emailTextField.text!, fullName: nameTextField.text!, dateOfBirth: dateFormatter.string(from: ageDatePicker.date)
, gender: genderSegment.titleForSegment(at: genderSegment.selectedSegmentIndex)!, phoneNumber: phoneTextField.text!))
        })
        
    }
    
}





// Ai Solution
//let ratio: Float = 1/6
//var progress: Float = 0
//print(Int(ageTextField.text ?? ""))
//let validationRules: [UITextField: (String) -> Bool] = [
//    nameTextField: { $0.count >= 3 },
//    emailTextField: { $0.contains("@") && $0.count >= 6 },
//    ageTextField: {text in
//    let count = text.count
//    if count <= 3, count > 1, let age = Int(text) {
//        return age >= 18
//    }
//    return false},
//    phoneTextField: { $0.count == 8 || ($0.count >= 8 && $0.filter({ $0 == "+" }).count == 1) },
//    passwordTextField: { $0.count >= 6 },
//    confirmPasswordTextField: { $0 == self.passwordTextField.text ?? "" && $0.count >= 6 }
//]
//
//for (textField, validationRule) in validationRules {
//    if validationRule(textField.text ?? "") {
//        progress += ratio
//    }
//}
//
//progressBar.setProgress(Float(progress), animated: true)
