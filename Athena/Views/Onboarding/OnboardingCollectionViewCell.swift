//
//  OnboardingCollectionViewCell.swift
//  Athena
//
//  Created by Alex Henbest on 2/21/24.
//

import UIKit

// Custom collection view cell for displaying onboarding slides
class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // Static property to define a reusable identifier for the cell
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    // Outlets for UI elements within the cell
    @IBOutlet weak var slideimageView: UIImageView!      // Image view for the slide image
    @IBOutlet weak var slideTitle: UILabel!               // Label for the slide title
    @IBOutlet weak var slideDescription: UILabel!         // Label for the slide description
    
    // Method to configure the cell with data from an OnboardingSlide
    func setup(_ slide: OnboardingSlide) {
        slideimageView.image = slide.image            // Set the image view's image
        slideTitle.text = slide.title                 // Set the title label's text
        slideDescription.text = slide.description     // Set the description label's text
    }
}
