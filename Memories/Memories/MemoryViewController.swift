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
    var person: Person?
    
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
        guard let title = memoryTitleTextField.text, !title.isEmpty,
            let info = memoryInfoTextView.text, !info.isEmpty,
            let person = person else { return }
        let people = NSSet(array: [person])
        MemoryController.createMemory(title: title, memoryInfo: info, people: people)
        
//        var tag: String
//        for button in buttonArray {
//            if button.isEnabled == false {
//                tag = button.titleLabel!.text!
//                TagController.createTag(tag: tag, memory: memory)
//            }
//        }
//        let tags = NSSet(array: [tag])
        
//        let memory = Memory(title: title, memoryInfo: info, timestamp: Date(), people: people)
//
//        guard let photo = memoryPhotoImageView.image else { return }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectMemoryPhotoButtonTapped(_ sender: Any) {
    }
    
    @IBAction func happyButtonTapped(_ sender: Any) {
        buttonArray = tagButtonWasTapped(tappedButton: happyButton)
    }
    
    @IBAction func sadButtonTapped(_ sender: Any) {
        buttonArray = tagButtonWasTapped(tappedButton: sadButton)
    }
    
    @IBAction func funnyButtonTapped(_ sender: Any) {
        buttonArray = tagButtonWasTapped(tappedButton: funnyButton)
    }
    
    @IBAction func seriousButtonTapped(_ sender: Any) {
        buttonArray = tagButtonWasTapped(tappedButton: seriousButton)
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






















