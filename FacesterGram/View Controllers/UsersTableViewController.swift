//
//  UsersTableViewController.swift
//  FacesterGram
//
//  Created by Louis Tur on 10/21/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    // Describe what these three keywords indicate about UserTableViewCellIdentifier
    private static let UserTableViewCellIdentifier: String = "UserTableViewCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.shared.getRandomUserData { (data: Data?) in
            if data != nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
                    if let resultsJSON = json["results"] as? [String : AnyObject] {
//                        let user = 
                    }
                    
                }
                catch {
                    print("Error Occurred: \(error.localizedDescription)")
                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 

}
