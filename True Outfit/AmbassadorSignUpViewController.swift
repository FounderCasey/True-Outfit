//
//  AmbassadorSignUpViewController.swift
//  True Outfit
//
//  Created by Casey Wilcox on 1/12/17.
//  Copyright © 2017 Casey Wilcox. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AmbassadorSignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
        
        emailTextField.delegate = self
        firstnameTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(AmbassadorSignUpViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AmbassadorSignUpViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func signUp(_ sender: Any) {
        let data = UIImageJPEGRepresentation(self.profileImageView.image!, 0.8)
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (firstnameTextField.text?.isEmpty)! {
            alert(title: "Uh Oh!", message: "Be sure to fill out all forms.")
        } else {
            ambassadorSignUp(firstName: firstnameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, data: data! as NSData)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
