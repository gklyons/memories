//
//  Occasion+Convenience.swift
//  Memories
//
//  Created by Garrett Lyons on 9/22/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData

extension Occasion {
    convenience init(title: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
    }
    
    @NSManaged public var photo: Data?
    @NSManaged public var events: NSOrderedSet?
    
}
