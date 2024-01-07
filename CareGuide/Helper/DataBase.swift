//
//  DataBase.swift
//  CareGuide
//
//  Created by Ali Jasim on 08/10/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DataBase {
    static let db = DataBase()
    
    private init (){}
        
    let db = Firestore.firestore()
    
    func createUser(_ selfViewController:UIViewController,email:String,password:String,completion: @escaping (Error?) -> Void){
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password,completion:{authResult,error in
            guard error == nil else{
                if let error = error as? NSError {
                    print(error)
                    self.getErrMessage(selfViewController,error: error)
                    return
                }else {
                    Helper.shared.showAlert(Controller: selfViewController, title: "Invalid Sign Up", message: "Check your registration form")
                    completion(error)
                    return
                }
            }
            selfViewController.navigationController?.popToRootViewController(animated: true)
            Helper.shared.showAlert(Controller: selfViewController, title: "Acount Created", message: "Account Successfully Created")
            UserDefaults.standard.set(Auth.auth().currentUser!.uid,forKey: "user_uid_key")
            completion(nil)
        })
    }
    
    func getErrMessage(_ self:UIViewController,error:NSError){
        var title,message : String
        switch error.code{
        case 17026:
            title = "Invalid Password"
            message = "The password must be 6 characters long or more"
            break
        case 17007:
            title = "Invalid Email"
            message = "The email address is already in use by another account"
            break
        default:
             title = "Network Issue"
            message = "Please check that you are conntected to wifi"
            break
        }
        Helper.shared.showAlert(Controller: self, title: title, message: message)
        
    }
        func saveUserData(user:User){
            let userData: [String: Any] = [
                "fullName": user.fullName,
                "email": user.email,
                "gender": user.gender,
                "age": user.dateOfBirth,
                "phoneNumber": user.phoneNumber
            ]
            // Add a new user in collection
            db.collection("Users").document("\(Auth.auth().currentUser!.uid)").setData(userData, merge: true)
            { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    
    func checkUserType(uid: String,userType:String ,completion: @escaping (Bool) -> Void) {
        let docRef = db.collection(userType).document("\(uid)")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    // sample data to check booking history for patient
    static var bookings =  [Booking]()
    
        static func load(){
            if bookings.isEmpty {
                bookings = sampleBookings
            }
    }
    static var sampleBookings = [
        Booking(status: .Cancelled, name: "IBN Al Nafees" , testType: "blood", date: "2022-03-11" , location: "Manama"),
        Booking(status: .Upcoming, name: "IBN Al Nafees", testType: "pressure", date: "2022-03-11" , location: "Manama")

    ]
    
}
