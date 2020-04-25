//
//  FriendsTableViewController.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-21.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Students List"

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.studentsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendTableViewCell

        // Configure the cell...
        cell.studentNameLabel.text = "\(StudentModel.studentsList[indexPath.row].firstName) \(StudentModel.studentsList[indexPath.row].lastName)"
        cell.mediaURL = StudentModel.studentsList[indexPath.row].mediaURL

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        let currentStudent = StudentModel.studentsList[indexPath.row]
        let mediaURL = currentStudent.mediaURL
        
        
        if let urlMedia = URL(string: mediaURL) {
            if (app.canOpenURL(urlMedia)) {
                app.open(urlMedia)
            } else {
                displayAlert(message: "URL not valid")
            }
        } else {
            displayAlert(message: "URL not valid")
        }
    }
    
    func displayAlert(message: String) {
        let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        StudentClient.logout { (success, error) in
            if success {
                let loginViewController = (self.storyboard?.instantiateViewController(identifier: "LoginViewController")) as! LoginViewController
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
            
            if let error = error {
                self.displayAlert(message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func reloadTable(_ sender: Any) {
        StudentClient.getStudentList { (response, error) in
            if let response = response {
                StudentModel.studentsList = response.studentsList
                self.tableView.reloadData()
            }
            
            if let error = error {
                self.displayAlert(message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func addNewLocation(_ sender: Any) {
        let addNewLocationViewController = self.storyboard?.instantiateViewController(identifier: "AddNewLocation") as! AddNewLocationViewController
        
        present(addNewLocationViewController, animated: true, completion: nil)
    }
    
}
