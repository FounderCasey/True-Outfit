//
//  Brand.swift
//  True Outfit
//
//  Created by Casey Wilcox on 2/26/17.
//  Copyright © 2017 Casey Wilcox. All rights reserved.
//

import Foundation
import Firebase

struct Brand {
    let key: String
    let name: String
    let bio: String
    let uid: String
    let ref: FIRDatabaseReference?
    
    init(name: String, bio: String, uid: String, key: String = "") {
        self.key = key
        self.name = name
        self.bio = bio
        self.uid = uid
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        key = snapshot.key
        name = snapshotValue["name"] as! String
        bio = snapshotValue["bio"] as! String
        uid = snapshotValue["uid"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "bio": bio
        ]
    }
}
