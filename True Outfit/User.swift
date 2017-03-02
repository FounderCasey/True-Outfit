//
//  User.swift
//  True Outfit
//
//  Created by Casey Wilcox on 2/26/17.
//  Copyright © 2017 Casey Wilcox. All rights reserved.
//

import Foundation
import Firebase

struct User {
    var firstName: String!
    var email: String!
    var photoUrl: String!
    var uid: String!
    var key: String?
    var ref: FIRDatabaseReference?

    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        key = snapshot.key
        email = snapshotValue["email"] as! String
        firstName = snapshotValue["firstName"] as! String
        photoUrl = snapshotValue["photoUrl"] as! String
        uid = snapshotValue["uid"] as! String
        ref = snapshot.ref
    }
}
