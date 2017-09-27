//
//  MemoryViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/19/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    
    var buttonArray: [TagButton] = []
    var person: Person?
    var memory: Memory?
    
    // MARK: - IBOutlets
    
  
    @IBOutlet weak var memoryTitleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var memoryPhotoImageView: UIImageView!
    @IBOutlet weak var happyButton: TagButton!
    @IBOutlet weak var sadButton: TagButton!
    @IBOutlet weak var funnyButton: TagButton!
    @IBOutlet weak var seriousButton: TagButton!
    
    // MARK: - IBActions
    
    
    @IBAction func memoryButtonTapped(_ sender: Any) {
    
    let imagePicker = UIImagePickerController()
    
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated:  true, completion: nil)
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = memoryTitleTextField.text, !title.isEmpty,
            let info = textView.text, !info.isEmpty,
            let person = person else { return }
        let people = NSSet(array: [person])
<<<<<<< HEAD
        MemoryController.createMemoryFromPerson(title: title, memoryInfo: info, people: people)
=======
        MemoryController.createMemory(title: title, memoryInfo: info, people: people)
        guard let photo = memoryPhotoImageView.image else { return }
>>>>>>> developLogan
        
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
        
        if memory != nil {
            memoryTitleTextField.text = memory?.title
            memoryInfoTextView.text = memory?.memoryInfo
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "Enter memory here")
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        memoryPhotoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
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






















