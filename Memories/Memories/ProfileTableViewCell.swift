//
//  ProfileTableViewCell.swift
//  Memories
//
//  Created by Caleb Strong on 9/25/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let personName = nameTextField.text, !personName.isEmpty,
            let personPhoto = profilePictureImageView.image else { return }
        
        delegate?.saveButtonTapped(name: personName, photo: personPhoto)
    }
    
    @IBAction func selectImageButtonTapped(_ sender: Any) {
        delegate?.selectImageButtonTapped()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - Delegate Property
    
    weak var delegate: ProfileTableViewCellDelegate?
}

// MARK: - Delegate Protocol

protocol ProfileTableViewCellDelegate: class {
    func saveButtonTapped(name: String, photo: UIImage)
    
    func selectImageButtonTapped()
}














