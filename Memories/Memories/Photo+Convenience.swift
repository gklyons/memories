//
//  Photo+Convenience.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData

extension Photo {
    
    convenience init(photo: NSData, memory: Memory, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.photo = photo
        self.memory = memory
    }
}
