//
//  CreateAccountViewController.swift
//  Athena
//
//  Created by Alex Henbest on 2/26/24.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var invalidText: UILabel!
    @IBOutlet weak var checkPasswordsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invalidText.isHidden = true
        self.checkPasswordsLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        guard let email = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        guard password == confirmPassword else {
            self.invalidText.isHidden = false
            self.checkPasswordsLabel.isHidden = false
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                self.invalidText.isHidden = false
                self.checkPasswordsLabel.isHidden = false
            } else {
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }
}

