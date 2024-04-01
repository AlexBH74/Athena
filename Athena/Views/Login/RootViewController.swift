//
//  FirstViewController.swift
//  Athena
//
//  Created by Alex Henbest on 3/28/24.
//

import UIKit
import Firebase

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "keepSignedIn")
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
