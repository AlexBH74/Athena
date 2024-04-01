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
                if strongSelf.keepSignedInSwitch.isOn {
                    UserDefaults.standard.setValue(true, forKey: "keepSignedIn")
                }
                strongSelf.performSegue(withIdentifier: "goToNext", sender: strongSelf)
            }
        }
    }
}
