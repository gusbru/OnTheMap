//
//  ViewController.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-21.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        let tabBarViewController = storyboard?.instantiateViewController(identifier: "TabBarController") as! TabBarViewController
        
        navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    


}

