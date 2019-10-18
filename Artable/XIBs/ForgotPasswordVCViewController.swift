//
//  ForgotPasswordVCViewController.swift
//  Artable
//
//  Created by Anupam Deb on 18/10/19.
//  Copyright © 2019 Anupam Deb. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVCViewController: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetPassClicked(_ sender: Any) {
        guard let email = emailTxt.text , email.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please enter email.")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                debugPrint(error)
                self.handleFireAuthError(error: error)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
