//
//  CorrectViewController.swift
//  Athena
//
//  Created by Alex Henbest on 4/29/24.
//

import UIKit

class CorrectViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var time: String = ""
    var lastInsertedTime: String = ""
    
    private var timer: Timer = Timer()
    private var num: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc func timerCounter() -> Void {
        num += 1

        let correctTimes = UserDefaults.standard.object(forKey: "easyCorrectTimes") as? [String]
        
        let index = correctTimes!.count
        
        if index != 0 {
            lastInsertedTime = correctTimes![index-1]
            
            time = "Time: " + lastInsertedTime
            
            self.timeLabel.text = time
        }
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        
    }
}
