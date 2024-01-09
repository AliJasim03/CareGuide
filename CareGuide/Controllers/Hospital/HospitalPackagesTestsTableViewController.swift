//
//  HospitalPackagesTestsTableViewController.swift
//  CareGuide
//
//  Created by Lui on 09/01/2024.
//

import UIKit

class HospitalPackagesTestsTableViewController: UITableViewController {

    var selectedSegmentIndex = 0
    var data: [Any] = [] // An array to store tests and packages

    var tests: [Test] = []
    var packages: [Package] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(self, action: #selector(SegmentController(_:)), for: .valueChanged)
       
        tests = loadArrays()?.0 ?? []
        packages = loadArrays()?.1 ?? []

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections based on the selected index
        return selectedSegmentIndex == 1 ? 2 : 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return selectedSegmentIndex == 1 ? 0 : 2
        default:
            return 0
        }
    }

    struct Test: Codable {
        var name: String
        var price: Double
        var description: String
    }
    
    struct Package: Codable {
        var name: String
        var price: Double
        var description: String
        var tests: [Test]
    }
    
    
    @IBOutlet weak var NameTxtField: UITextField!
    
    
    @IBOutlet weak var DescriptionTxt: UITextField!
    @IBOutlet weak var PriceTxt: UITextField!
    
    
    @IBAction func SaveBtn(_ sender: Any) {
        
        switch selectedSegmentIndex {
        case 1:
            let testName = NameTxtField.text ?? ""
            let testPrice = Double(PriceTxt.text ?? "") ?? 0.0
            let description = DescriptionTxt.text ?? ""
            let test = Test(name: testName, price: testPrice, description: description)

            tests.append(test)
        case 0:
            let testName = NameTxtField.text ?? ""
            let testPrice = Double(PriceTxt.text ?? "") ?? 0.0
            let description = DescriptionTxt.text ?? ""
            let package = Package(name: testName, price: testPrice, description: description, tests: [])
            packages.append(package)

        default:
            print("Error")
        }
        saveArrays(tests, packages)
    }
    
    
    
    var selectedSegment = 0

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func SegmentController(_ sender: UISegmentedControl) {
        // Update the selected index property
        selectedSegmentIndex = sender.selectedSegmentIndex

        // Reload the table view to reflect the changes
        tableView.reloadData()
    }
    
    
    func saveArrays(_ array1: [Test], _ array2: [Package]) {
       let encoder = JSONEncoder()
       if let encoded1 = try? encoder.encode(array1),
          let encoded2 = try? encoder.encode(array2) {
           UserDefaults.standard.set(encoded1, forKey: "TestsKey")
           UserDefaults.standard.set(encoded2, forKey: "PackagesKey")
       }
    }


    func loadArrays() -> ([Test], [Package])? {
       if let savedData1 = UserDefaults.standard.data(forKey: "TestsKey"),
          let savedData2 = UserDefaults.standard.data(forKey: "PackagesKey"),
          let loadedArray1 = try? JSONDecoder().decode([Test].self, from: savedData1),
          let loadedArray2 = try? JSONDecoder().decode([Package].self, from: savedData2) {
           return (loadedArray1, loadedArray2)
       }
       return nil
    }

    
}
