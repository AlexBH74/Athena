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
    
    let correctTimes = UserDefaults.standard.object(forKey: "easyCorrectTimes") as? [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popUpShowing = UserDefaults.standard.bool(forKey: "correctShowing")
        if popUpShowing == true {
            let index = correctTimes!.count
            print(index)
            
            lastInsertedTime = correctTimes![index-1]
            print(lastInsertedTime)
            
            time = "Time: " + lastInsertedTime
            print(time)
            
            self.timeLabel.text = time
        }
    }

    @IBAction func homeClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "correctShowing")
    }
}
