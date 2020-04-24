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
        let username = EmailTextField.text ?? ""
        let password = PasswordTextField.text ?? ""
        
        if (username.isEmpty || password.isEmpty) {
            showErrorAlert(message: "email and/or password empty")
            return
        }
        
        StudentClient.login(username: username, password: password, completion: handleLogin(success:error:))
    }
    
    
    private func handleLogin(success: Bool, error: Error?) {
        if !success {
            // display error
            showErrorAlert(message: error?.localizedDescription ?? "Something went wrong :(")
            return
        }
        
        // move to next view
        let tabBarViewController = storyboard?.instantiateViewController(identifier: "TabBarController") as! TabBarViewController
        navigationController?.pushViewController(tabBarViewController, animated: true)
        
    }
    
    private func showErrorAlert(message: String) {
        let alertViewController = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
    


}

