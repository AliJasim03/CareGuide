//
//  Alert.swift
//  CareGuide
//
//  Created by Rashed Albuainain on 04/01/2024.
//

import UIKit

extension UIViewController {
    
    func confirmation(title: String, message: String?, confirmHandler: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Yes", style: .default) {
            action in confirmHandler()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
