//
//  TagController.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation

class TagController {
    
    // MARK: - CRUD Functions
    
    static func createTag(tag: String, memory: Memory) {
        let _ = Tag(tag: tag, memories: memory)
        PersonController.shared.saveToPersistentStore()
    }
    
    static func updateTag(tag: Tag){
        if let moc = tag.managedObjectContext {
            try! moc.save()
        }
        
        PersonController.shared.saveToPersistentStore()
    }
    
    static func deleteTag(tag: Tag) {
        if let moc = tag.managedObjectContext {
            moc.delete(tag)
            PersonController.shared.saveToPersistentStore()
        }
    }
}
