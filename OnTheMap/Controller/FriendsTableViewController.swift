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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Students List"

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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

}
