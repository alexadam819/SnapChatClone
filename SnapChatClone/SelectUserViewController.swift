//
//  SelectUserViewController.swift
//  SnapChatClone
//
//  Created by a1667 on 8/15/17.
//  Copyright © 2017 a1667. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource =  self

        Database.database().reference().child("user").observe(
            DataEventType.childAdded, with: {(snapshot) in
                let user = User()
                user.email = (snapshot.value as! NSDictionary)["email"] as! String
                user.uid = snapshot.key
                
                self.users.append(user)
                self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
     
}
