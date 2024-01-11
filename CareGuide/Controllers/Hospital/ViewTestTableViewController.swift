import UIKit

class ViewTestTableViewController: UITableViewController {
    
    var savedTestNames: [String]? // Array to store fetched test names
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch saved test names
        if let names = UserDefaults.standard.array(forKey: "selectedTests") as? [String] {
            savedTestNames = names
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming a single section
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedTestNames?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use the "viewTest" cell identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewTest", for: indexPath)
        
        if let savedTestNames = savedTestNames {
            cell.textLabel?.text = savedTestNames[indexPath.row]
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Show confirmation alert
            let alert = UIAlertController(title: "Delete Test", message: "Are you sure you want to delete this test?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                // Proceed with deletion
                var savedTestNames = UserDefaults.standard.array(forKey: "selectedTests") as? [String] ?? []
                savedTestNames.remove(at: indexPath.row)
                UserDefaults.standard.set(savedTestNames, forKey: "selectedTests")
                
                self.savedTestNames?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            present(alert, animated: true)
        }
    }
    
    
}
