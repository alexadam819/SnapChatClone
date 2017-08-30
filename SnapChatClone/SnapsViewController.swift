//
//  SnapsViewController.swift
//  SnapChatClone
//
//  Created by a1667 on 8/10/17.
//  Copyright © 2017 a1667. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var snapTable: UITableView!
    @IBOutlet weak var demoTextField: UITextField!
    var snaps : [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snapTable.dataSource = self
        snapTable.delegate = self
        Database.database().reference().child("user").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
            let snap  = Snap()
            snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.snapDesc = (snapshot.value as! NSDictionary)["description"] as! String
            
            self.snaps.append(snap)
            self.snapTable.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        return cell
    }

    @IBAction func logOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ demoTextField: UITextField) {
        moveTextField(demoTextField, moveDistance: -250, up: true)
        print("Here")
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ demoTextField: UITextField) {
        moveTextField(demoTextField, moveDistance: -250, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ demoTextField: UITextField) -> Bool {
        demoTextField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ demoTextField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }

}
