//
//  AmbassadorSettingsViewController.swift
//  True Outfit
//
//  Created by Casey Wilcox on 2/23/17.
//  Copyright © 2017 Casey Wilcox. All rights reserved.
//

import UIKit

class AmbassadorSettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        //profileImage.layer.borderColor = UIColor.gray.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
    }

    @IBAction func chooseImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
