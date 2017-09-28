//
//  MemoryController.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import UIKit

class MemoryController {
    
    // MARK: - CRUD Functions
    
    static func createMemoryFromPerson(title: String, memoryInfo: String, people: NSSet, photo: UIImage, tag: String) {
        let memory = Memory(title: title, memoryInfo: memoryInfo, people: people, occasion: nil)
        PhotoController.createPhoto(photo: photo, memory: memory)
        TagController.createTag(tag: tag, memory: memory)
        PersonController.shared.saveToPersistentStore()
    }
    
    static func createMemoryFromOccasion(title: String, memoryInfo: String, photo: UIImage, occasion: Occasion) {
        let memory = Memory(title: title, memoryInfo: memoryInfo, people: nil, occasion: occasion)
        PhotoController.createPhoto(photo: photo, memory: memory)
        PersonController.shared.saveToPersistentStore()
    }
    
    static func updateMemory(memory: Memory, photo: Photo, tag: Tag) {
        PhotoController.updatePhoto(photo: photo)
        TagController.updateTag(tag: tag)
        if let moc = memory.managedObjectContext {
            try! moc.save()
        }
        
        PersonController.shared.saveToPersistentStore()
    }
    
    static func deleteMemory(memory: Memory) {
        if let moc = memory.managedObjectContext {
            moc.delete(memory)
            PersonController.shared.saveToPersistentStore()
        }
    }
    
    
}
