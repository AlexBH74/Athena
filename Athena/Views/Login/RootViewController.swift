//
//  FirstViewController.swift
//  Athena
//
//  Created by Alex Henbest on 3/28/24.
//

import UIKit
import Firebase

class RootViewController: UIViewController {
    
    let isLoggedIn  = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check the condition when the view loads
        if isLoggedIn == true {
            goToHomescreen()
        }
    }
    
    func goToHomescreen() {
        let controller = storyboard?.instantiateViewController(identifier: "Homescreen") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
}
