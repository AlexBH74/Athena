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
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var medBtn: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShadows()
        
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    @objc func logOutButtonTapped(_ sender: UIButton) {

        UserDefaults.standard.set(false, forKey: "keepSignedIn")
        
        let controller = storyboard?.instantiateViewController(identifier: "LoginPage") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
    func addShadows() {
        self.easyBtn.layer.shadowColor = UIColor(red: 0/255, green: 75/255, blue: 0/255, alpha: 1).cgColor
        self.easyBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.easyBtn.layer.shadowOpacity = 1.0
        self.easyBtn.layer.shadowRadius = 1.0
        self.easyBtn.layer.masksToBounds = false
        
        self.medBtn.layer.shadowColor = UIColor(red: 75/255, green: 75/255, blue: 0/255, alpha: 1).cgColor
        self.medBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.medBtn.layer.shadowOpacity = 1.0
        self.medBtn.layer.shadowRadius = 1.0
        self.medBtn.layer.masksToBounds = false
        
        self.hardBtn.layer.shadowColor = UIColor(red: 75/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.hardBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.hardBtn.layer.shadowOpacity = 1.0
        self.hardBtn.layer.shadowRadius = 1.0
        self.hardBtn.layer.masksToBounds = false
    }
}
