//
//  WelcomeViewController.swift
//  CKUsers
//
//  Created by Austin West on 6/5/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = UserController.shared.currentUser
            else { return }
        welcomeLabel.text = "Welcome \(currentUser.firstName)!"

    }

}
