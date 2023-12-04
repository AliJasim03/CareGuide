//
//  SettingTableViewController.swift
//  CareGuide
//
//  Created by Lui on 04/12/2023.
//

import UIKit
import FirebaseAuth

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkDarkModePreference()

    }

    // MARK: - Table view data source

    
    @IBOutlet weak var ContactUsBtn: UIButton!

    @IBOutlet weak var SignOutBtn: UIBarButtonItem!
    
    @IBOutlet weak var AboustUsBtn: UIButton!
    
    @IBOutlet weak var DeleteAccountBtn: UIButton!
    
    @IBOutlet weak var DarkModeSwitch: UISwitch!
    
    
    @IBAction func DarkModeSwitch(_ sender: UISwitch) {
        if sender.isOn {
                // Dark mode enabled
                applyDarkMode()
                UserDefaults.standard.set(true, forKey: "darkModeEnabled")
            } else {
                // Dark mode disabled
                applyLightMode()
                UserDefaults.standard.set(false, forKey: "darkModeEnabled")
            }
    }
    
    func applyDarkMode() {
        // Implement dark mode UI changes here
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene {
             scene.windows.first?.overrideUserInterfaceStyle = .dark
        }
    }

    func applyLightMode() {
        // Implement light mode UI changes here
        // Update UI elements to their original light-themed appearance.
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene {
             scene.windows.first?.overrideUserInterfaceStyle = .light
        }
    }

    
    func checkDarkModePreference() {
        // Retrieve the user's preference for dark mode
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        if isDarkModeEnabled {
            DarkModeSwitch.setOn(true, animated: true)
        } else {
            DarkModeSwitch.setOn(false, animated: true)
        }
    }


    @IBAction func SignOutBtn(_ sender: Any) {
        do{
            try FirebaseAuth.Auth.auth().signOut()
        } catch {
            print("Error Signing out")
        }
        UserDefaults.standard.removeObject(forKey: "user_uid_key")
        UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(
            name: "Main",
            bundle: nil
        )
        let newVc = storyboard.instantiateViewController(withIdentifier: "Main")
        self.view.window!.rootViewController = newVc
    }
    
    
    
    
    @IBAction func DeleteAccountBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account?", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                // Perform account deletion
                self.deleteAccount()
            }
            alertController.addAction(deleteAction)

            present(alertController, animated: true, completion: nil)
        
        
    
    }
    
    
    
    @IBAction func ContactUsBtn(_ sender: Any) {
    }
    
    
    
    func deleteAccount() {
        // Perform account deletion logic here
        let user = FirebaseAuth.Auth.auth().currentUser

        user?.delete { error in
            if let error = error {
                print("Error deleting account: \(error.localizedDescription)")
                // Handle error (show alert, log, etc.)
            } else {
                // Account deleted successfully
                print("Account deleted successfully")

                // Clear user UID from UserDefaults
                UserDefaults.standard.removeObject(forKey: "user_uid_key")
                UserDefaults.standard.synchronize()

                // Show success alert
                let successAlert = UIAlertController(title: "Success", message: "Account deleted successfully", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    // Navigate to the home page
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let newVc = storyboard.instantiateViewController(withIdentifier: "Main")
                    self.view.window!.rootViewController = newVc
                })
                successAlert.addAction(okAction)
                self.present(successAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    

}