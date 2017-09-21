//
//  Tag+Convenience.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData

extension Tag {
    convenience init(tag: String, memories: NSSet, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.tag = tag
        self.memories = memories
    }
}
