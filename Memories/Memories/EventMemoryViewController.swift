//
//  EventMemoryViewController.swift
//  Memories
//
//  Created by Garrett Lyons on 9/26/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class EventMemoryViewController: UIViewController, UIImagePickerControllerDelegate {
    
    // MARK - Properties
    
    var occasion: Occasion?
    var memory: Memory?
    
    // MARK - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoryTextView: UITextView!
    @IBOutlet weak var eventMemoryImageView: UIImageView!
    
    // MARK - Action
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty,
            let memory = memoryTextView.text, !memory.isEmpty else { return }
        guard let occasion = self.occasion else { return }

        MemoryController.createMemoryFromOccasion(title: title, memoryInfo: memory, occasion: occasion)

        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if memory != nil  {
            guard let memory = memory else { return }
            titleTextField.text = memory.title
            memoryTextView.text = memory.memoryInfo
        }
    }
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button Captured")
            
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated:  true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            eventMemoryImageView.image = selectedImage
            dismiss(animated: true, completion: nil)
            
        }
        
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
