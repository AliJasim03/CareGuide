//
// SVTestTableViewController.swift
// CareGuide
//
// Created by Rashed Mohamed Saad Ebrahim Saeed Albuainain on 10/01/2024.
//

import UIKit

class SVTestTableViewController: UITableViewController {
    
    let medicalTestNames = [
        "Urinalysis",
        "Liver Function Tests",
        "Electrolytes Test",
        "Hemoglobin A1c Test",
        "Thyroid-Stimulating Hormone (TSH) Test",
        "Prostate-Specific Antigen (PSA) Test",
        "Pap Smear",
        "Colonoscopy",
        "Chest X-Ray",
        "Electrocardiogram (ECG)",
        "Bone Density Scan",
        "Magnetic Resonance Imaging (MRI)",
        "Computed Tomography (CT) Scan",
        "Positron Emission Tomography (PET) Scan",
        "Lumbar Puncture"
    ]
    var selectedTestIndices = [Int]()
    
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the custom cell class if using one
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "TestCell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming a single section
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicalTestNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectTest", for: indexPath)

                cell.textLabel?.text = medicalTestNames[indexPath.row]

                // Set accessoryType based on selection state
                cell.accessoryType = isSelected(at: indexPath) ? .checkmark : .none

                return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Toggle selection state
            toggleSelection(at: indexPath)

            // Update cell appearance
            tableView.cellForRow(at: indexPath)?.accessoryType = isSelected(at: indexPath) ? .checkmark : .none

            // Deselect the row to prevent it from staying highlighted
            tableView.deselectRow(at: indexPath, animated: true)
        }
    func isSelected(at indexPath: IndexPath) -> Bool {
        return selectedTestIndices.contains(indexPath.row)
        }

        func toggleSelection(at indexPath: IndexPath) {
            if isSelected(at: indexPath) {
                    // Deselect the test
                    selectedTestIndices.removeAll { $0 == indexPath.row }
                } else {
                    // Select the test
                    selectedTestIndices.append(indexPath.row)
                }
        }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // Access the selected test indices from selectedTestIndices array
            let selectedTestNames = selectedTestIndices.map { medicalTestNames[$0] }

            // Perform saving logic here
            // For example:
            UserDefaults.standard.set(selectedTestNames, forKey: "selectedTests")

        navigationController?.popViewController(animated: true)
    }
}
