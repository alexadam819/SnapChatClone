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
    
    @IBOutlet weak var uploadSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadSpinner.isHidden = true
        uploadSpinner.stopAnimating()
        uploadSpinner.hidesWhenStopped = true
        imagePicker.delegate = self
        nextButton.isEnabled = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        snapImage.image = image
        snapImage.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        uploadSpinner.isHidden = false
        uploadSpinner.startAnimating()
        nextButton.isEnabled = false
        let imageStorage = Storage.storage().reference().child("images")
        // let imageData : Data = UIImagePNGRepresentation(snapImage.image!)!
        let imageData : Data = UIImageJPEGRepresentation(snapImage.image!, 0.1)!
        imageStorage.child("\(NSUUID().uuidString).jpg").putData(
            imageData, metadata: nil, completion:{(metadata, error) in
                if error != nil{
                    print("Error:")
                }else{
                    self.uploadSpinner.stopAnimating()
                    self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()?.absoluteString)
                }
            }
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let nextVS = segue.destination as! SelectUserViewController
        nextVS.imageURL = sender as! String
        nextVS.snapDesc = snapDescription.text!
    }
}
