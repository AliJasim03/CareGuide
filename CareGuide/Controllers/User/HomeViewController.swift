import UIKit

class HomeViewController: UIViewController {

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
   var filteredHospitals: [Hospital] = []

   @IBOutlet weak var collectionView: UICollectionView!

   override func viewDidLoad() {
       super.viewDidLoad()
       collectionView.dataSource = self
       collectionView.delegate = self
       filteredHospitals = getFilteredHospitals()
       let layout = UICollectionViewFlowLayout()
       layout.estimatedItemSize = CGSize(width: collectionView.bounds.width, height: 200)
       layout.minimumLineSpacing = 10 // Set the spacing between cells vertically
       layout.minimumInteritemSpacing = 10 // Set the spacing between cells horizontally
       collectionView.collectionViewLayout = layout
   }

   @IBAction func SegmentController(_ sender: UISegmentedControl) {
       currentSegment = sender.selectedSegmentIndex
       filteredHospitals = getFilteredHospitals()
       collectionView.reloadData()
   }
   
   func getFilteredHospitals() -> [Hospital] {
       switch currentSegment {
       case 0:
           return hospitals.filter { $0.type == "General" }
       case 1:
           return hospitals.filter { $0.type == "Children" }
       case 2:
           return hospitals.filter { $0.type == "Maternity" }
       default:
           return hospitals
       }
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
       return filteredHospitals.count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
}

extension HomeViewController: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let hospital = filteredHospitals[indexPath.item]
       print("Selected hospital: \(hospital.title)")
       // Perform your action here
   }
}
