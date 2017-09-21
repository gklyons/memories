//
//  Group+Convenience.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData

extension Group {
    convenience init(name: String, people: NSSet, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.people = people
    }
}
