//
//  SignUpViewController.swift
//  CKUsers
//
//  Created by Austin West on 6/5/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        
        guard let username = userNameTextField.text,
            !username.isEmpty,
            let firstName = firstNameTextField.text,
            !firstName.isEmpty
            else { return }
        
        UserController.shared.createNewUser(username: username, firstName: firstName) { (success) in
            
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toWelcomeFromSignUp", sender: nil)
                }
            } else {
                //    handle error
            }
        }
    }
}
