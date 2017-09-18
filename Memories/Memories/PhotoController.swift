//
//  PhotoController.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import UIKit

class PhotoController {
    
    // MARK: - CRUD Functions
    
    static func createPhoto(photo: UIImage, memory: Memory) {
        guard let photoData = UIImageJPEGRepresentation(photo, 1) as NSData? else { return }
        let _ = Photo(photo: photoData, memory: memory)
        PersonController.shared.saveToPersistentStore()
    }
    
    static func deletePhoto(photo: Photo) {
        if let moc = photo.managedObjectContext {
            moc.delete(photo)
            PersonController.shared.saveToPersistentStore()
        }
    }
}
