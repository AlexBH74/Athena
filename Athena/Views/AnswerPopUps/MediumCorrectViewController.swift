//
//  MediumCorrectViewController.swift
//  Athena
//
//  Created by Alex Henbest on 5/8/24.
//

import UIKit

class MediumCorrectViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var time: String = ""
    var lastInsertedTime: String = ""
    
    private var timer: Timer = Timer()
    private var num: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(correctDisplayCounter), userInfo: nil, repeats: true)
    }
    
    @objc func correctDisplayCounter() -> Void {
        let display = UserDefaults.standard.bool(forKey: "mediumCorrectShowing")
        if display == true {
            let correctTimes = UserDefaults.standard.object(forKey: "mediumCorrectTimes") as? [String]
            
            let index = correctTimes!.count
            
            if index != 0 {
                lastInsertedTime = correctTimes![index-1]
                
                time = "Time - " + lastInsertedTime
                
                self.timeLabel.text = time
            }
        }
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "mediumCorrectShowing")
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