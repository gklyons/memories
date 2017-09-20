//
//  PersonViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/19/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    // MARK - Properties
    
    var imagePicker = UIImagePickerController()
    var person = Person(name: "", photo: nil)
    var memories: [Memory] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var personPhotoImageView: UIImageView!
    @IBOutlet weak var memoryListTableView: UITableView!
    
    // MARK: - IBActions
    
    @IBAction func personPhotoButtonTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated:  true, completion: nil)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let personName = personNameTextField.text, !personName.isEmpty,
            let personPhoto = personPhotoImageView.image else { return }
        
        PersonController.shared.createPerson(name: personName, photo: personPhoto)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func newMemoryButtonTapped(_ sender: Any) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        personPhotoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        personNameTextField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        personNameTextField.delegate = self
        memoryListTableView.dataSource = self
        memoryListTableView.delegate = self
        
        if person.name != "" {
            personNameTextField.text = person.name
            guard let photo = UIImage(data: person.photo! as Data, scale: 1.0) else { return }
            personPhotoImageView.image = photo
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoryListTableView.reloadData()
    }
    
    // MARK: - Memory List Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell")
        
        let memory = memories[indexPath.row]
        cell?.textLabel?.text = memory.title
        cell?.detailTextLabel?.text = "\(memory.timestamp)"
   
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMemoryView" {
            let person = self.person
            let memoryVC = segue.destination as? MemoryViewController
            memoryVC?.person = person
        }
    }
}


























