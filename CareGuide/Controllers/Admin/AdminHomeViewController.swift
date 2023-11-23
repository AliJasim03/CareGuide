//
//  AdminHomeViewController.swift
//  CareGuide
//
//  Created by Ali Jasim on 23/11/2023.
//

import UIKit

class AdminHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutTappedButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "admin_uid_key")
        UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(
            name: "Main",
            bundle: nil
        )
        let newVc = storyboard.instantiateViewController(withIdentifier: "Main")
        self.view.window!.rootViewController = newVc
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
