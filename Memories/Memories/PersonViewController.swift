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
    var person: Person?

    
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
        
        if person != nil {
            personNameTextField.text = person?.name
            guard let data = person?.photo as Data? else { return }
            guard let photo = UIImage(data: data, scale: 1.0) else { return }
            personPhotoImageView.image = photo
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoryListTableView.reloadData()

    }
    
    // MARK: - Memory List Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let memories = person?.memories else { return 0 }
        return memories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell")
        
        guard let memories = person?.memories else { return UITableViewCell() }
        let memoriesArray = Array(memories)
        guard let memory = memoriesArray[indexPath.row] as? Memory else { return UITableViewCell() }
        
        cell?.textLabel?.text = memory.title
        cell?.detailTextLabel?.text = "\(String(describing: memory.timestamp))"
   
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let memories = person?.memories else { return }
            let memoriesArray = Array(memories)
            guard let memory = memoriesArray[indexPath.row] as? Memory else { return }
            MemoryController.deleteMemory(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMemoryView" {
            guard let person = self.person else { return }
            let memoryVC = segue.destination as? MemoryViewController
            memoryVC?.person = person
        }
    }
}


























