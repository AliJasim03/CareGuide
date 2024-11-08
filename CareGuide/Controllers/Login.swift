//
//  ViewController.swift
//  CareGuide
//
//  Created by Ali Jasim on 19/09/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class Login: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var topConstaint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
           self,
           selector: #selector(self.keyboardWillShow),
           name: UIResponder.keyboardWillShowNotification,
           object: nil)

        NotificationCenter.default.addObserver(
           self,
           selector: #selector(self.keyboardWillHide),
           name: UIResponder.keyboardWillHideNotification,
           object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
       if emailTextField.isEditing || passwordTextField.isEditing {
           adjustConstraintForKeyboard(show: true, notification: notification)
       }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
       adjustConstraintForKeyboard(show: false, notification: notification)
    }

    func adjustConstraintForKeyboard(show: Bool, notification: NSNotification) {
       guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
       let keyboardHeight = keyboardSize.height
       let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
       let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!

       if show {
           topConstaint.constant = 0
       } else {
           topConstaint.constant = 30
       }

       let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
           self?.view.layoutIfNeeded()
       }

       animator.startAnimation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          
                setBorderColor(for: view)
            
        
    }
    @IBAction func loginButtonTapped(_ sender: Any) {


        guard Helper.shared.wrapTextFields(textFields: [emailTextField,passwordTextField]) else{
            Helper.shared.showAlert(Controller: self, title: "Missing field data", message: "Please fill in the required fields")
        return
        }
        
        let texts = Helper.shared.getTextFromTextField(textFields:[emailTextField,passwordTextField])
       
        let email = texts[0]
        let password = texts[1]
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, error in
            guard error == nil else{
                Helper.shared.showAlert(Controller: self, title: "Invalid Credentials", message: "Check your email or password")
                return
            }

        })

        
        if Auth.auth().currentUser?.uid == nil {
            return
        }
        print(Auth.auth().currentUser?.uid)
        DataBase.db.checkUserType(uid: Auth.auth().currentUser!.uid,userType: "Users",
                                    completion: {
            isUser in if isUser{
                UserDefaults.standard.set(Auth.auth().currentUser!.uid,forKey: "user_uid_key")
                let storyboard = UIStoryboard(name: "UserTabBar", bundle: nil)
                let newVc = storyboard.instantiateViewController(withIdentifier: "UserTabBar")
                self.view.window!.rootViewController = newVc        }
        })
        
        DataBase.db.checkUserType(uid: Auth.auth().currentUser!.uid,userType: "Hospitals",
                                    completion: {
            isUser in if isUser{

            UserDefaults.standard.set(Auth.auth().currentUser!.uid,forKey: "hospital_uid_key")
            let storyboard = UIStoryboard(
                name: "HospitalTabBar",
                bundle: nil
            )
            let newVc = storyboard.instantiateViewController(withIdentifier: "HospitalTabBar")
            self.view.window!.rootViewController = newVc        }
        })
        
        if email.lowercased() == "admin@gmail.com"{
            UserDefaults.standard.set(Auth.auth().currentUser!.uid,forKey: "admin_uid_key")
            let storyboard = UIStoryboard(name: "AdminTabBar", bundle: nil)
            let newVc = storyboard.instantiateViewController(withIdentifier: "AdminTabBar")
            self.view.window!.rootViewController = newVc
        }
        // This does not do anything
//      self.performSegue(withIdentifier: "UserHome", sender: self)

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
    
}

