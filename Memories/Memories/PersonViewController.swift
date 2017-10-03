//
//  PersonViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/19/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit
import CoreData

class PersonViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate, ProfileTableViewCellDelegate {
    
    // MARK - Properties
    
    var imagePicker = UIImagePickerController()
    var person: Person?

    var image: UIImage?

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var memoryListTableView: UITableView!
    
    
    // MARK: - IBActions
    

    @objc func newMemoryButtonTapped() {
        self.performSegue(withIdentifier: "ToMemoryVC", sender: self)
    }

    @IBAction func personPhotoButtonTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated:  true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoryListTableView.dataSource = self
        memoryListTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoryListTableView.reloadData()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Memory List Table View Data Source Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let newMemoryButton = UIButton()
            newMemoryButton.setTitle("New Memory", for: .normal)
            newMemoryButton.backgroundColor = .blue
            newMemoryButton.setTitleColor(.black, for: .normal)
            newMemoryButton.addTarget(self, action: #selector(PersonViewController.newMemoryButtonTapped), for: .touchUpInside)
            return newMemoryButton
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            guard let memories = person?.memories else { return 1 }
            if memories.count == 0 {
                return 1
            } else {
                return memories.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoryCell")
            
            guard let memories = person?.memories else { return UITableViewCell() }
            if memories.count == 0 {
                return UITableViewCell()
            } else {
                let memoriesArray = Array(memories)
                guard let memory = memoriesArray[indexPath.row] as? Memory else { return UITableViewCell() }
                
                cell?.textLabel?.text = memory.title
                cell?.detailTextLabel?.text = dateFormatter.string(from: memory.timestamp!)
                
                return cell ?? UITableViewCell()
            }
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ProfileTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            cell.nameTextField.delegate = self
            
            if person != nil {
                cell.nameTextField.text = person?.name
                guard let photoData = person?.photo else { return UITableViewCell() }
                let image = UIImage(data: photoData)
                cell.profilePictureImageView.image = image
            } else {
                if image == nil {
                    cell.profilePictureImageView.image = #imageLiteral(resourceName: "addnew")
                } else {
                    cell.profilePictureImageView.image = image
                }

            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let memories = person?.memories else { return }
            let memoriesArray = Array(memories)
            guard let memory = memoriesArray[indexPath.row] as? Memory else { return }
            let alert = UIAlertController(title: "Are you sure?", message: "You are going to delete \(memory.title ?? "this memory").", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let okayAction = UIAlertAction(title: "Okay", style: .default) { (uiAlertAction) in
                MemoryController.deleteMemory(memory: memory)
//                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - ProfileTableViewCellDelegate Functions
    
    func saveButtonTapped(name: String, photo: UIImage) {
        if self.person == nil {
            guard let image = image else { return }
            PersonController.shared.createPerson(name: name, photo: image)
        } else {
            guard let person = person else { return }
            person.name = name
            guard let photoData = UIImageJPEGRepresentation(photo, 1) as NSData? else { return }
            person.photo = photoData as Data
            PersonController.shared.updatePerson(person: person)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func selectImageButtonTapped() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated:  true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if person == nil {
            image = selectedImage
        } else {
            person?.photo = UIImageJPEGRepresentation(selectedImage, 1)
        }
        
        memoryListTableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func reloadTV(closure: @escaping () -> Void) {
        memoryListTableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMemoryVC" {
            guard let person = self.person else { return }
            let memoryVC = segue.destination as? MemoryViewController
            memoryVC?.person = person
        } else {
            guard let index = memoryListTableView.indexPathForSelectedRow,
                let person = self.person,
                let memories = person.memories else { return }
            let memoryArray = Array(memories)
            guard let memory = memoryArray[index.row] as? Memory else { return }
            let memoryVC = segue.destination as? MemoryViewController
            memoryVC?.memory = memory
            memoryVC?.person = person
        }
    }
}


























