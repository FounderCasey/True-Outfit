//
//  AmbassadorMenuTableViewController.swift
//  True Outfit
//
//  Created by Casey Wilcox on 2/26/17.
//  Copyright © 2017 Casey Wilcox. All rights reserved.
//

import UIKit
import Firebase

class AmbassadorMenuTableViewController: UITableViewController {

    let ref = FIRDatabase.database().reference(withPath: "brands")
    var brands: [Brand] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref.queryOrdered(byChild: "task").observe(.value, with: { snapshot in
            var brandsList: [Brand] = []
            
            for brand in snapshot.children {
                let brandItem = Brand(snapshot: brand as! FIRDataSnapshot)
                brandsList.append(brandItem)
            }
            self.brands = brandsList
            self.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell") as! BrandTableViewCell
        let brand = brands[indexPath.row]
        cell.nameLabel.text = brand.name
        cell.bioLabel.text = brand.bio
        return cell
    }

}
