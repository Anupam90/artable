//
//  LoginVC.swift
//  Artable
//
//  Created by Anupam Deb on 17/9/19.
//  Copyright © 2019 Anupam Deb. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func forgotPassBtnClicked(_ sender: Any) {
        let vc = ForgotPasswordVCViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    @IBAction func loginClicked(_ sender: Any) {
        guard let email = emailTxt.text , email.isNotEmpty ,
            let password = passwordTxt.text, password.isNotEmpty else {
                simpleAlert(title: "Error", msg: "Please out all fields.")
                return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                self?.handleFireAuthError(error: error)
                self?.activityIndicator.stopAnimating()
                return
            }
            self?.activityIndicator.stopAnimating()
            print("Login Was Successful!")
            self?.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func guestClicked(_ sender: Any) {
    }
    
}
