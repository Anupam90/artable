//
//  ViewController.swift
//  Artable
//
//  Created by Anupam Deb on 17/9/19.
//  Copyright © 2019 Anupam Deb. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    //Outlets
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil || Auth.auth().currentUser?.isAnonymous == true {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    debugPrint(error)
                    self.handleFireAuthError(error: error)
                }
                print("Login Anonymously Successful!")
                self.loginOutBtn.title = "Login"
            }
        } else {
            print("Login as registered user!")
            self.loginOutBtn.title = "Logout"
        }
    }
//
//    //for this viewDidAppear function when then app is started running it will start from loginVC
//    override func viewDidAppear(_ animated: Bool) {
//        if let user = Auth.auth().currentUser , !user.isAnonymous {
//            loginOutBtn.title = "Logout"
//        } else {
//            loginOutBtn.title = "Login"
//        }
//    }
    
    fileprivate func presentLoginController() {
        let storyBoard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: StoryboardID.LoginVC)
        present(controller, animated: true, completion: nil)
    }

    @IBAction func loginOutClicked(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else {return}
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                print("Logout Button Clicked!!")
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        self.handleFireAuthError(error: error)
                        debugPrint(error)
                    }
                    self.presentLoginController()
                }
            } catch {
                self.handleFireAuthError(error: error)
                debugPrint(error)
            }
        }
    }
}
