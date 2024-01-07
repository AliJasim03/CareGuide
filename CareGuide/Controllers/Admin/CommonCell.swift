//
//  CommonCell.swift
//  MP Features TEST MP
//
//  Created by Hadi Alrahmani on 03/01/2024.
//

import UIKit

// Define a custom UITableViewCell subclass named CommonCell
/* This line declares a Swift class named CommonCell that is a subclass of UITableViewCell. This class is a custom cell used for displaying information in a table view. */

class CommonCell: UITableViewCell {
    
    // Outlets to connect UI elements from the storyboard
    /* These lines declare outlets for connecting UI elements from the storyboard to the CommonCell class. Each outlet is associated with a specific UI element:
     
     Img1: An UIImageView used for displaying an image.
     TimingsLbl: A UILabel used for displaying timings information.
     nameLabel: A UILabel used for displaying the name information.
     locationLabel: A UILabel used for displaying the location information.
     These outlets allow the code to access and manipulate the content of these UI elements within the cell. */
    
    @IBOutlet weak var Img1: UIImageView!      // Image view for displaying an image
    @IBOutlet weak var TimingsLbl: UILabel!     // Label for displaying timings information
    @IBOutlet weak var nameLabel: UILabel!       // Label for displaying the name information
    @IBOutlet weak var locationLabel: UILabel!   // Label for displaying the location information
}
