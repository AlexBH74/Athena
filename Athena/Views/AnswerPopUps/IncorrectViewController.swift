//
//  IncorrectViewController.swift
//  Athena
//
//  Created by Alex Henbest on 4/30/24.
//

import UIKit

class IncorrectViewController: UIViewController {
    
    @IBOutlet weak var answerLabel: UILabel!
    
    private var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }

    @objc func timerCounter() -> Void {
        let incorrectShowing = UserDefaults.standard.bool(forKey: "easyIncorrectShowing")
        if incorrectShowing == true{
            let answer = UserDefaults.standard.string(forKey: "easyCorrectAnswer")
            self.answerLabel.text = answer
        }
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "easyIncorrectShowing")
        goToHomescreen()
    }
    
    func goToHomescreen() {
        let controller = storyboard?.instantiateViewController(identifier: "Homescreen") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }

}
