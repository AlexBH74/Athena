//
//  LoginViewController.swift
//  Athena
//
//  Created by Alex Henbest on 2/23/24.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var keepSignedInSwitch: UISwitch!
    @IBOutlet weak var invalidText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invalidText.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let email = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.invalidText.isHidden = false
                print("Sign-in error: \(error.localizedDescription)")
            } else {
                let n = self?.retrieveCount()
                if n == 0 {
                    UserDefaults.standard.set(true, forKey: "firstTime")
                }
                
                let firstTime = UserDefaults.standard.bool(forKey: "firstTime")
                
                if firstTime == true  {
                    if strongSelf.keepSignedInSwitch.isOn {
                        UserDefaults.standard.setValue(true, forKey: "keepSignedIn")
                    }
                    //self?.incrementAndSaveCount()
                    //UserDefaults.standard.set(false, forKey: "firstTime")
                    strongSelf.performSegue(withIdentifier: "goToNext", sender: strongSelf)
                }
                else {
                    if strongSelf.keepSignedInSwitch.isOn {
                        UserDefaults.standard.setValue(true, forKey: "keepSignedIn")
                    }
                    self?.goToHomescreen()
                }
            }
        }
    }
    func goToHomescreen() {
        let controller = storyboard?.instantiateViewController(identifier: "Homescreen") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
    func incrementAndSaveCount() {
        var count = UserDefaults.standard.integer(forKey: "countKey")
        count += 1
        print(count)
        UserDefaults.standard.set(count, forKey: "countKey")
    }
    
    func retrieveCount() -> Int {
        return UserDefaults.standard.integer(forKey: "countKey")
    }
}
