//
//  HomescreenViewController.swift
//  Athena
//
//  Created by Alex Henbest on 2/23/24.
//

import UIKit

class HomescreenViewController: UIViewController {

    private var currentDate = Date()
    let format = DateFormatter()
    private var easy = UserDefaults.standard.bool(forKey: "easyDone")
    private var medium = UserDefaults.standard.bool(forKey: "mediumDone")
    private var hard = UserDefaults.standard.bool(forKey: "hardDone")
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var easyLockImage: UIImageView!
    @IBOutlet weak var mediumLockImage: UIImageView!
    @IBOutlet weak var hardLockImage: UIImageView!
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var medBtn: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.easyLockImage.isHidden = true
        self.mediumLockImage.isHidden = true
        self.hardLockImage.isHidden = true
        
        format.dateFormat = "yyyy-MM-dd"
        let date = format.string(from: currentDate)
        
        var easyLastDate = UserDefaults.standard.string(forKey: "easyLastDate")
        //easyLastDate = nil  //comment out
        if easyLastDate == nil {
            easyLastDate = "2024-01-01"
            print(easyLastDate!)
        } else {
            print(easyLastDate!)
        }
        
        if date == easyLastDate {
            print(date)
            easy = UserDefaults.standard.bool(forKey: "easyDone")
        } else {
            print(date)
            UserDefaults.standard.set(false, forKey: "easyDone")
            easy = UserDefaults.standard.bool(forKey: "easyDone")
        }
        
        if easy == true {
            easyBtn.isEnabled = false
            self.easyLockImage.isHidden = false
        } else {
            easyBtn.isEnabled = true
            print(easy)
        }
        
        
        var mediumLastDate = UserDefaults.standard.string(forKey: "mediumLastDate")
        //mediumLastDate = nil  //comment out
        if mediumLastDate == nil {
            mediumLastDate = "2024-01-01"
            print(mediumLastDate!)
        } else {
            print(mediumLastDate!)
        }
        
        if date == mediumLastDate {
            print(date)
            medium = UserDefaults.standard.bool(forKey: "mediumDone")
        } else {
            print(date)
            UserDefaults.standard.set(false, forKey: "mediumDone")
            medium = UserDefaults.standard.bool(forKey: "mediumDone")
        }
        
        if medium == true {
            medBtn.isEnabled = false
            self.mediumLockImage.isHidden = false
        } else {
            medBtn.isEnabled = true
            print(medium)
        }

        
        var hardLastDate = UserDefaults.standard.string(forKey: "hardLastDate")
        //hardLastDate = nil  //comment out
        if hardLastDate == nil {
            hardLastDate = "2024-01-01"
            print(hardLastDate!)
        } else {
            print(hardLastDate!)
        }
        
        if date == hardLastDate {
            print(date)
            hard = UserDefaults.standard.bool(forKey: "hardDone")
        } else {
            print(date)
            UserDefaults.standard.set(false, forKey: "hardDone")
            hard = UserDefaults.standard.bool(forKey: "hardDone")
        }
        
        if hard == true {
            hardBtn.isEnabled = false
            self.hardLockImage.isHidden = false
        } else {
            hardBtn.isEnabled = true
            print(hard)
        }
        
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
