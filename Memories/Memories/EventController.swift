//
//  EventController.swift
//  Memories
//
//  Created by Garrett Lyons on 9/22/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import UIKit

class EventController {
    
    static func createEvent(title: String, memoryInfo: String, timestamp: Date = Date()) {
        let _ = Event(title: title, memoryInfo: memoryInfo, timestamp: timestamp)
        OccasionController.shared.saveToPersistentStore()
    }
    
    static func deleteEvent(event: Event) {
        if let moc = event.managedObjectContext {
            moc.delete(event)
            OccasionController.shared.saveToPersistentStore()
        }
    }
}
