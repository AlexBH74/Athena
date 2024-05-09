//
//  HardIncorrectViewController.swift
//  Athena
//
//  Created by Alex Henbest on 5/8/24.
//

import UIKit

class HardIncorrectViewController: UIViewController {
    
    @IBOutlet weak var answerLabel: UILabel!
    
    private var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(incorrectDisplayCounter), userInfo: nil, repeats: true)
    }

    @objc func incorrectDisplayCounter() -> Void {
        let incorrectShowing = UserDefaults.standard.bool(forKey: "hardIncorrectShowing")
        if incorrectShowing == true{
            let answer = UserDefaults.standard.string(forKey: "hardCorrectAnswer")
            self.answerLabel.text = answer
        }
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "hardIncorrectShowing")
        timer.invalidate()
        goToHomescreen()
    }
    
    func goToHomescreen() {
        let controller = storyboard?.instantiateViewController(identifier: "Homescreen") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }

}
