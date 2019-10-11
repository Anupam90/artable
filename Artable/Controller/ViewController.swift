//
//  ViewController.swift
//  Artable
//
//  Created by Anupam Deb on 17/9/19.
//  Copyright © 2019 Anupam Deb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //for this viewDidAppear function when then app is started running it will start from loginVC
    override func viewDidAppear(_ animated: Bool) {
        let storyBoard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: StoryboardID.LoginVC)
        present(controller, animated: true, completion: nil)
    }

}
