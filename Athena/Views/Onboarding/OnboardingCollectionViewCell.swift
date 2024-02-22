//
//  OnboardingCollectionViewCell.swift
//  Athena
//
//  Created by Alex Henbest on 2/21/24.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideimageView: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideimageView.image = slide.image
        slideTitle.text = slide.title
        slideDescription.text = slide.description
    }
}
