//
//  FetchViewController.swift
//  CKUsers
//
//  Created by Austin West on 6/5/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class FetchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UserController.shared.fetchCurrentUser { (success) in
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toWelcomeFromFetch", sender: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toSignup", sender: nil)
                }
            }
        }
    }
    
}
