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
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                self.invalidText.isHidden = false
            }
            else {
                if self.keepSignedInSwitch.isOn {
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                }
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }
    
}
