////
////  AdminHomeViewController.swift
////  CareGuide
////
////  Created by Ali Jasim on 23/11/2023.
////
//
//import UIKit
//import FirebaseAuth
//
//class HospitalHomeViewController: UIViewController {
//    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
//    
//    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
//        switch segmentControlOutlet.selectedSegmentIndex{
//        case 0:
//            //medical package
//            print("hello")
//        case 1:
//            //medical test
//            print("hello")
//        default:
//            break
//        }
//    }
//    
//    let medicalPackage : [String] = []
//    let medicalTest : [String] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let medicalpackage = "" // Replace this with the actual value of fmedicalpackage
//               
//               if medicalpackage.isEmpty {
//                   print("There is no medical package to display")
//               } else {
//                   // Perform other operations if the segment is not empty
//                   // ...
//               }
//        // Do any additional setup after loading the view.
//    }
//    
////    override func numberOfSection() -> Int {
////        return 1
////    }
////
////    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return medicalPackage.count
////    }
////
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.packageCell, for: indexPath) as! MedicalPackageTableViewCell
////
////        let package = medicalPackage[indexPath.row]
////        cell.configure(medicalpackage: medicalpackage)
////        return cell
////    }
//    
////    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
////        if editingStyle == .delete {
////     confirmation(title: "Delete Confirmation", message: "Are you sure you want to delete this package?")
////            tableView.deleteRows(at: [IndexPath], with: .fade)
////        }
//////    }
////
//    
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addMedicalPackage"{
//            
//        }
//    }
//    
//
//    
//    
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
