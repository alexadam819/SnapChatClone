//
//  SignInViewController.swift
//  SnapChatClone
//
//  Created by a1667 on 8/9/17.
//  Copyright © 2017 a1667. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (User, Error) in
            if Error != nil{
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (User, Error) in
                    print("We tried to make a user.")
                    if Error != nil{
                        print("Error Creating User: \n \(Error!)")
                    }else {
                        Database.database().reference().child("user")
                            .child((User?.uid)!)
                            .child("email")
                            .setValue(User?.email)
                        self.performSegue(withIdentifier: "signInSegue" , sender: nil)
                    }
                })
            }else{
                print("Sign in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        }
        
    }

}

