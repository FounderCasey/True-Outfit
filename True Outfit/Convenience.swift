//
//  Convenience.swift
//  True Outfit
//
//  Created by Casey Wilcox on 7/30/16.
//  Copyright © 2016 Casey Wilcox. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController {

    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func signOut() {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
                self.alert(title: "Oops...", message: "\(error.localizedDescription)")
            }
        }
    }
    
    // Ambassador Firebase Model
    func ambassadorSignUp(firstName: String, email: String, password: String, data: NSData) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.ambassadorSetUserInfo(user: user!, firstName: firstName, password: password, data: data)
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            } else {
                self.alert(title: "Oops...", message: "\(error!.localizedDescription)")
            }
        })
    }
    
    private func ambassadorSaveInfo(user: FIRUser, firstName: String, password: String) {
        let userInfo = ["email": user.email, "firstName": firstName, "uid": user.uid, "photoUrl": String(describing: user.photoURL!)]
        let userRef = FIRDatabase.database().reference().child("users").child(user.uid)
        
        userRef.setValue(userInfo)
    }
    
    func ambassadorSignIn(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            } else {
                self.alert(title: "Oops...", message: "\(error!.localizedDescription)")
            }
        })
    }
    
    private func ambassadorSetUserInfo(user: FIRUser, firstName: String, password: String, data: NSData) {
        let imagePath = "profileImage\(user.uid)/userImage.png"
        let imageRef = FIRStorage.storage().reference().child(imagePath)
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        imageRef.put(data as Data, metadata: metaData) { (metaData, error) in
            if error == nil {
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = firstName
                
                if let photoURL = metaData!.downloadURL() {
                    changeRequest.photoURL = photoURL
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        self.ambassadorSaveInfo(user: user, firstName: firstName, password: password)
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            } else {
                self.alert(title: "Oops...", message: "\(error!.localizedDescription)")
            }
        }
    }
    
    // Brand Firebase Model
}

