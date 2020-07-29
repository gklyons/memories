//
//  SelectPersonTableViewCell.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class SelectPersonTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var isSelectedButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func personIsSelectedButtonTapped(_ sender: Any) {
        delegate?.personWasSelected(cell: self)
    }
    
    // MARK: - Properties and UpdateView
    
    var person: Person? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let person = person else { return }
        
        nameLabel.text = person.name
        let image = person.isSelected ? #imageLiteral(resourceName: "complete") : #imageLiteral(resourceName: "incomplete")
        isSelectedButton.setBackgroundImage(image, for: .normal)
    }
    
    // MARK: - Delegate
    
    weak var delegate: SelectPersonTableViewCellDelegate?
    
}

// MARK: - Delegate Protocol

protocol SelectPersonTableViewCellDelegate: class {
    func personWasSelected(cell: SelectPersonTableViewCell)
}
