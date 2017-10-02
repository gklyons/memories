//
//  EventMemoryViewController.swift
//  Memories
//
//  Created by Garrett Lyons on 9/26/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class EventMemoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    // MARK - Properties
    
    var occasion: Occasion?
    var memory: Memory?
    var photo: Photo?
    
    // MARK - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoryTextView: UITextView!
    @IBOutlet weak var eventMemoryImageView: UIImageView!
    
    // MARK - Action
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty,
            let memoryInfo = memoryTextView.text, !memoryInfo.isEmpty,
            let photo = eventMemoryImageView.image,
            let occasion = occasion else { return }
        
        if memory == nil {
            MemoryController.createMemoryFromOccasion(title: title, memoryInfo: memoryInfo, photo: photo, occasion: occasion)
        }
        //            let occasion = occasion
        //            occasion.title = title
        //            let photoData = UIImageJPEGRepresentation(photo, 1)
        //            self.photo?.photo = photoData
        //            guard self.photo != nil else { return }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    func textView(_ memoryTextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n")
        {
            memoryTextView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        memoryTextView.delegate = self
        
        
        if memory != nil  {
            guard let memory = memory else { return }
            titleTextField.text = memory.title
            memoryTextView.text = memory.memoryInfo
            
            guard let photos = memory.photos else { return }
            let photosArray = Array(photos) as! [Photo]
            guard let photoData = photosArray[0].photo else { return }
            let photo = UIImage(data: photoData)
            eventMemoryImageView.image = photo
        }
    }
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button Captured")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated:  true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        eventMemoryImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
