//
//  TagButton.swift
//  Memories
//
//  Created by Caleb Strong on 9/19/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class TagButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? UIColor(red: 60/255.0, green: 134/255.0, blue: 179/255.0, alpha: 1.0) : UIColor.lightGray
        }
    }
}
