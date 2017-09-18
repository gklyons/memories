//
//  Memory+Convenience.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData

extension Memory {
    
    convenience init(title: String, timestamp: Date, person: Person, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.timestamp = timestamp as NSDate
        self.person = person
    }
}
