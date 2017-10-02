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
    var tag: Tag?
    var photo: Photo?
    var tagString: String?
    
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
        guard let photo = memoryPhotoImageView.image else { return }

        for button in buttonArray {
            if button.isEnabled == false {
                self.tagString = button.titleLabel!.text!
            }
        }
        
        guard let tagString = tagString else { return }
        
        if memory == nil {
            MemoryController.createMemoryFromPerson(title: title, memoryInfo: info, people: people, photo: photo, tag: tagString)
        } else {
            guard let memory = memory else { return }
            memory.title = title
            memory.memoryInfo = info
            let photoData = UIImageJPEGRepresentation(photo, 1.0)
            self.photo?.photo = photoData
            guard let photo = self.photo,
                let tag = self.tag else { return }
            tag.tag = tagString
            MemoryController.updateMemory(memory: memory, photo: photo, tag: tag)
        }
        
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
            textView.text = memory?.memoryInfo

            guard let photos = memory?.photos else { return }
            let photosArray = Array(photos) as! [Photo]
            guard let photoData = photosArray[0].photo else { return }
            memoryPhotoImageView.image = UIImage(data: photoData)
            self.photo = photosArray[0]
            
            let buttonArray: [TagButton] = [happyButton, sadButton, funnyButton, seriousButton]
            for button in buttonArray {
                if button.titleLabel?.text == memory?.tags?.tag {
                    button.isEnabled = false
                    self.tag = memory?.tags
                    self.tagString = memory?.tags?.tag
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        memoryPhotoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func tagButtonWasTapped(tappedButton: TagButton) -> [TagButton] {
        let buttonArray: [TagButton] = [happyButton, sadButton, funnyButton, seriousButton]
        for button in buttonArray {
            if button != tappedButton {
                button.isEnabled = true
            } else {
                button.isEnabled = false
            }
        }
        
        return buttonArray
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
 }






















