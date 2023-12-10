//
//  HomeCollectionViewCell.swift
//  CareGuide
//
//  Created by Lui on 07/12/2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    struct Hospital {
        let title: String
        let image: UIImage
        let type: String
    }
    @IBOutlet weak var HomeDescriptionLabel: UILabel!
    @IBOutlet weak var HomeTitleLabel: UILabel!
    @IBOutlet weak var HomeImageView: UIImageView!
    
    func configure(with hospital: HomeViewController.Hospital) {
        HomeTitleLabel.text = hospital.title
        HomeDescriptionLabel.text = hospital.type
        HomeImageView.image = hospital.image
    }
    
}
