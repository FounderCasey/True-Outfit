//
//  FirebaseModel.swift
//  True Outfit
//
//  Created by Casey Wilcox on 2/25/17.
//  Copyright © 2017 Casey Wilcox. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseModel {
    private func saveInfo(user: FIRUser, firstName: String, password: String) {
        let userInfo = ["email": user.email, "firstName": firstName, "uid": user.uid, "photoUrl": String(describing: user.photoURL)]
        let userRef = FIRDatabase.database().reference().child("users").child(user.uid)
        
        userRef.setValue(userInfo)
    }
    
    func signIn(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    print("\(user.displayName) has signed in.")
                }
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    
    private func setUserInfo(user: FIRUser, firstName: String, password: String, data: NSData) {
        let imagePath = "profileImage\(user.uid)/userImage.png"
        let imageRef = FIRStorage.storage().reference().child(imagePath)
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        imageRef.put(data as Data, metadata: metaData) { (metaData, error) in
            if error == nil {
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = firstName
                changeRequest.photoURL = metaData?.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        self.saveInfo(user: user, firstName: firstName, password: password)
                    } else {
                       print(error!.localizedDescription)
                    }
                })
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func signUp(firstName: String, email: String, password: String, data: NSData) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.setUserInfo(user: user!, firstName: firstName, password: password, data: data)
            } else {
                
                print(error!.localizedDescription)
            }
        })
    }
}
