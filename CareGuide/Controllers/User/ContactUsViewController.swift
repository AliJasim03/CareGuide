//
//  ContactUsViewController.swift
//  CareGuide
//
//  Created by Lui on 05/12/2023.
//

import UIKit

class ContactUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailButton: UIButton!


    @IBAction func emailButtonTapped(_ sender: UIButton) {
        if let email = emailButton.titleLabel?.text, let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
   

}

