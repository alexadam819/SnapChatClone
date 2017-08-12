//
//  PictureViewController.swift
//  SnapChatClone
//
//  Created by a1667 on 8/10/17.
//  Copyright © 2017 a1667. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var snapDescription: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as!
            UIImage
        
        snapImage.image = image
        
        snapImage.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier: "selectUserSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageStorage = Storage.storage().reference().child("images")
        let imageData = UIImagePNGRepresentation(snapImage.image!)!
        let imagePath = Auth.auth().currentUser!.uid +
            "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).png"
        print("#########################")
        print("#########################")
        print("#########################")
        print("\(imagePath)")

        imageStorage.child("image.png").put(imageData, metadata: nil, completion: {(metadata, error) in
            if error != nil{
                print("#########################")
                print("Error:")
            }
        })
    }

}
