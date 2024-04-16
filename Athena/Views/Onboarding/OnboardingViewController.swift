//
//  OnboardingViewController.swift
//  Athena
//
//  Created by Alex Henbest on 2/15/24.
//

// Importing the UIKit framework which provides fundamental building blocks for iOS app development
import UIKit

// Declaring a class named OnboardingViewController, subclassed from UIViewController, responsible for managing the onboarding flow
class OnboardingViewController: UIViewController {
    
    // Declaring IBOutlet properties representing UI elements
    @IBOutlet weak var collectionView: UICollectionView! // UICollectionView to display slides
    @IBOutlet weak var nextButton: UIButton! // Button to proceed to the next slide
    @IBOutlet weak var pageControl: UIPageControl! // Page control to indicate the current slide
    
    // Declaring a property to hold onboarding slides
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    // Method called after the view controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up the collection view delegate and data source
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Initializing the array of slides with dummy data
        slides = [
            OnboardingSlide(title: "Welcome to Athena!", description: "Are you ready to test the power of your mind?", image: #imageLiteral(resourceName: "slide1")),
            OnboardingSlide(title: "Introduction", description: "Athena is a daily trivia game that is a fun, competitive way to enhance your cognitive functionality and general knowledge", image: #imageLiteral(resourceName: "slide2")),
            OnboardingSlide(title: "Instructions", description: "When ready press \"Get Started!\" Then select your mode and press start to see a question with four multiple choice answers. Be as quick as possible, you'll be timed!", image: #imageLiteral(resourceName: "slide3.png"))
        ]
        
        pageControl.numberOfPages = slides.count
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // Action method called when the next button is clicked
    @IBAction func nextBtnClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "Homescreen") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

// Extension of OnboardingViewController to conform to UICollectionViewDelegate, UICollectionViewDataSource, and UICollectionViewDelegateFlowLayout protocols
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Method to specify the number of items in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    // Method to configure and return cells for the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    // Method to specify the size of items in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

