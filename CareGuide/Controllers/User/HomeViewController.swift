import UIKit

class HomeViewController: UIViewController {
    var selectedUser: User?
    var bookings: [Booking] = []
    struct Hospital {
        let title: String
        let image: UIImage
        let type: String
    }

    let hospitals: [Hospital] = [
            Hospital(title: "City General Hospital", image: UIImage(named: "AppIcon.jpeg")!, type: "General"),
            Hospital(title: "Kids Care Hospital", image: UIImage(named: "photo4.jpeg")!, type: "Children"),
            Hospital(title: "New Life Maternity Center", image: UIImage(named: "photo4.jpeg")!, type: "Maternity"),
            Hospital(title: "City General Hospital", image: UIImage(named: "photo4.jpeg")!, type: "General"),
            Hospital(title: "Kids Care Hospital", image: UIImage(named: "photo4.jpeg")!, type: "Children"),
            Hospital(title: "New Life Maternity Center", image: UIImage(named: "photo4.jpeg")!, type: "Maternity"),
            Hospital(title: "City General Hospital", image: UIImage(named: "photo4.jpeg")!, type: "General"),
            Hospital(title: "Kids Care Hospital", image: UIImage(named: "photo4.jpeg")!, type: "Children"),
            Hospital(title: "New Life Maternity Center", image: UIImage(named: "photo4.jpeg")!, type: "Maternity")
            // Add more hospitals as needed
        ]
    
    var currentSegment: Int = 0


    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
      super.viewDidLoad()
      collectionView.dataSource = self
      collectionView.delegate = self
      let layout = UICollectionViewFlowLayout()
      layout.estimatedItemSize = CGSize(width: collectionView.bounds.width, height: 200)
      layout.minimumLineSpacing = 10 // Set the spacing between cells vertically
      layout.minimumInteritemSpacing = 10 // Set the spacing between cells horizontally
      collectionView.collectionViewLayout = layout
    }

    

    @IBAction func SegmentController(_ sender: UISegmentedControl) {
        currentSegment = sender.selectedSegmentIndex
        collectionView.reloadData()
    }
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
       let size = image.size

       let widthRatio = targetSize.width / size.width
       let heightRatio = targetSize.height / size.height

       var newSize: CGSize
       if widthRatio > heightRatio {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
       }

       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
       image.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return newImage!
    }

    
    
    
    
}






extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let filteredHospitals: [Hospital]
        switch currentSegment {
        case 0:
            filteredHospitals = hospitals.filter { $0.type == "General" }
        case 1:
            filteredHospitals = hospitals.filter { $0.type == "Children" }
        case 2:
            filteredHospitals = hospitals.filter { $0.type == "Maternity" }
        default:
            filteredHospitals = hospitals
        }
        return filteredHospitals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let filteredHospitals: [Hospital]
       switch currentSegment {
       case 0:
           filteredHospitals = hospitals.filter { $0.type == "General" }
       case 1:
           filteredHospitals = hospitals.filter { $0.type == "Children" }
       case 2:
           filteredHospitals = hospitals.filter { $0.type == "Maternity" }
       default:
           filteredHospitals = hospitals
       }
       let hospital = filteredHospitals[indexPath.item]
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
       let resizedImage = resizeImage(image: hospital.image, targetSize: CGSize(width: 100, height: 100))
       cell.configure(with: Hospital(title: hospital.title, image: resizedImage, type: hospital.type))
       return cell
    }


}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
   public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let height = view.frame.size.height * 0.4
       let width = view.frame.size.width
       return CGSize(width: width, height: height)
   }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bookAction = UIContextualAction(style: .normal, title: "Book") { [weak self] (_, _, completionHandler) in
            self?.showDatePickerView(at: indexPath, completionHandler: completionHandler)
        }
        bookAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [bookAction])
    }
    
    func showDatePickerView(at indexPath: IndexPath, completionHandler: @escaping (Bool) -> Void) {
       
        let datePickerView = UIView(frame: CGRect(x: 10, y: view.bounds.height, width: view.bounds.width - 20, height: 180))
        datePickerView.backgroundColor = .white
        datePickerView.layer.cornerRadius = 10

        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.frame = CGRect(x: 0, y: 0, width: datePickerView.bounds.width, height: 150)

        
        let bookButton = UIButton(type: .system)
        bookButton.setTitle("Book", for: .normal)
        bookButton.frame = CGRect(x: 10, y: 130, width: datePickerView.bounds.width, height: 40)
        bookButton.layer.cornerRadius = 10 //
        bookButton.backgroundColor = .systemBlue
        bookButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        bookButton.setTitleColor(.white, for: .normal)

        
        datePickerView.addSubview(datePicker)
        datePickerView.addSubview(bookButton)

        
        datePicker.center.x = datePickerView.bounds.width / 2
        bookButton.center.x = datePickerView.bounds.width / 2

       
        datePickerView.frame.origin.y = self.view.bounds.height - 240

        
        view.addSubview(datePickerView)
        bookButton.addTarget(self, action: #selector(bookButtonTapped(_:)), for: .touchUpInside)

                datePickerView.addSubview(datePicker)
                datePickerView.addSubview(bookButton)

        
        UIView.animate(withDuration: 0.5) {
            datePickerView.frame.origin.y = self.view.bounds.height - 180
        }

        
        completionHandler(true)
    }
    
    @objc func bookButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.subviews.last?.frame.origin.y = self.view.bounds.height
        }) { _ in
            
            self.view.subviews.last?.removeFromSuperview()
        }
        
        let selectedHospital = hospitals[currentSegment]
        let newBooking = Booking(status: .upcoming, name: selectedHospital.title, testType: "Your Test Type", date: "", location: selectedHospital.type, price: "Your Price", include: "", patient: selectedUser)

                
        
                bookings.append(newBooking)

                
                if let historyViewController = tabBarController?.viewControllers?.first as? PBookinghistoryTableViewController {
                    historyViewController.bookings = bookings
                    historyViewController.tableView.reloadData()
                }

    }
    
}




