//
//  Event+Convenience.swift
//  Memories
//
//  Created by Garrett Lyons on 9/22/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData

extension Event {
    convenience init(title: String, memoryInfo: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.memoryInfo = memoryInfo
        self.timestamp = timestamp
    }
}

