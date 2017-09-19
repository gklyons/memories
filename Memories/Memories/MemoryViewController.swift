//
//  MemoryViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/19/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {

    // MARK: - Properties
    
    var buttonArray: [TagButton] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var memoryTitleTextField: UITextField!
    @IBOutlet weak var memoryInfoTextView: UITextView!
    @IBOutlet weak var memoryPhotoImageView: UIImageView!
    @IBOutlet weak var happyButton: TagButton!
    @IBOutlet weak var sadButton: TagButton!
    @IBOutlet weak var funnyButton: TagButton!
    @IBOutlet weak var seriousButton: TagButton!
    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func selectMemoryPhotoButtonTapped(_ sender: Any) {
    }
    
    @IBAction func happyButtonTapped(_ sender: Any) {
    }
    
    @IBAction func sadButtonTapped(_ sender: Any) {
    }
    
    @IBAction func funnyButtonTapped(_ sender: Any) {
    }
    
    @IBAction func seriousButtonTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tagButtonWasTapped(tappedButton: TagButton) -> [TagButton] {
        let buttonArray: [TagButton] = [happyButton, sadButton, funnyButton, seriousButton]
        for button in buttonArray {
            if button == tappedButton {
                button.isEnabled = false
            }
        }
        
        return buttonArray
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
 }
