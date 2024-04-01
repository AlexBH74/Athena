//
//  HomescreenViewController.swift
//  Athena
//
//  Created by Alex Henbest on 2/23/24.
//

import UIKit

class HomescreenViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func logOutButtonTapped(_ sender: UIButton) {

        UserDefaults.standard.set(false, forKey: "keepSignedIn")
        
        let controller = storyboard?.instantiateViewController(identifier: "LoginPage") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
}
