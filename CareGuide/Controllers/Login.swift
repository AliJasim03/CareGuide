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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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


        //TODO: fix the animation as it executes very fast
        UserDefaults.standard.set(Auth.auth().currentUser!.uid,forKey: "user_uid_key")
        let storyboard = UIStoryboard(name: "UserTabBar", bundle: nil)
        let newVc = storyboard.instantiateViewController(withIdentifier: "UserTabBar")
        self.view.window!.rootViewController = newVc
        // This does not do anything
//      self.performSegue(withIdentifier: "UserHome", sender: self)

    }
    
}

