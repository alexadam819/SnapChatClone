//
//  SnapsViewController.swift
//  SnapChatClone
//
//  Created by a1667 on 8/10/17.
//  Copyright © 2017 a1667. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var demoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
