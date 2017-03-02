//
//  AmbassadorLoginViewController.swift
//  True Outfit
//
//  Created by Casey Wilcox on 1/12/17.
//  Copyright © 2017 Casey Wilcox. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AmbassadorLoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let ref = FIRDatabase.database().reference(withPath: "brands")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(AmbassadorLoginViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AmbassadorLoginViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            alert(title: "Uh Oh!", message: "Be sure to fill out all forms.")
        } else {
            ambassadorSignIn(email: self.emailTextField.text!, password: self.passwordTextField.text!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
