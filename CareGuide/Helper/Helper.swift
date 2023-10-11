//
//  Helper.swift
//  CareGuide
//
//  Created by Ali Jasim on 06/10/2023.
//

import Foundation
import UIKit


class Helper {
    static let shared = Helper()
    
    private init (){}

    
    func wrapTextFields(textFields: [UITextField]) -> Bool {
        for textField in textFields {
            if let text = textField.text, text.isEmpty {
                return false
            }
        }
        return true
    }
    
    func getTextFromTextField(textFields:[UITextField]) ->[String]{
        var texts = [String]()
        for textField in textFields {
                texts.append(textField.text!)
        }
        return texts
        
    }
    
    func showAlert(Controller:UIViewController,title:String,message:String,preferredStyle:UIAlertController.Style = .alert ,style:UIAlertAction.Style = .cancel,buttonTitle:String = "OK",animated:Bool = true){
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle:     preferredStyle
        )
        alert.addAction(UIAlertAction(title: buttonTitle, style: style))
        
        Controller.present(alert,animated: animated)

    }
}
