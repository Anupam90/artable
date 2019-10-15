//
//  RegisterVC.swift
//  Artable
//
//  Created by Anupam Deb on 17/9/19.
//  Copyright © 2019 Anupam Deb. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    //outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var passCheckImg: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ textField : UITextField) {
        
        guard let passTxt = passwordTxt.text else {return}
        guard let conPassTxt = confirmPassTxt.text else {return}
        
        // If we have started typing in the confirm pass text field
        if textField == confirmPassTxt{
            if(passTxt.isEmpty && conPassTxt.isEmpty) {
                passCheckImg.isHidden = true
                confirmPassCheckImg.isHidden = true
            } else {
                passCheckImg.isHidden = false
                confirmPassCheckImg.isHidden = false
            }
        }
        else {
            if passTxt.isEmpty {
                passCheckImg.isHidden = true
                confirmPassCheckImg.isHidden = true
                confirmPassTxt.text = ""
            }
        }
        //Make it so when the passwords match, the checkmarks turn green.
        if passwordTxt.text == confirmPassTxt.text {
            passCheckImg.image = UIImage(named: AppImages.GreenCheck)
            confirmPassCheckImg.image = UIImage(named: AppImages.GreenCheck)
        } else {
            passCheckImg.image = UIImage(named: AppImages.RedCheck)
            confirmPassCheckImg.image = UIImage(named: AppImages.RedCheck)
        }
    }
    
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTxt.text , email.isNotEmpty,
            let username = usernameTxt.text , username.isNotEmpty,
            let confirmPass = confirmPassTxt.text , confirmPass.isNotEmpty,
            let password = passwordTxt.text , password.isNotEmpty else {return}
        activityIndicator.startAnimating()
        
        guard let authUser = Auth.auth().currentUser else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        authUser.link(with: credential) { (result, error) in
            if let error = error {
                debugPrint(error)
                print(error)
                self.activityIndicator.stopAnimating()
                return
                
            }
            self.activityIndicator.stopAnimating()
            print("Successfully registerd new user.")
            self.dismiss(animated: true, completion: nil)
        }
       
    }
}
