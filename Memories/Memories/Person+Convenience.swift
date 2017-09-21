//
//  Person+Convenience.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    convenience init(name: String, photo: NSData?, isSelected: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.photo = photo as Data?
        self.isSelected = isSelected
    }
}
