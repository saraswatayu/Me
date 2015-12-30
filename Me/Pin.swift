//
//  Pin.swift
//  Virtual Tourist
//
//  Created by Ayush Saraswat on 12/20/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

import Foundation
import CoreData

class Pin : NSManagedObject {

    @NSManaged var timeStamp: NSTimeInterval
    @NSManaged var title: String
    @NSManaged var lat: Float
    @NSManaged var long: Float
    @NSManaged var pictures: NSOrderedSet
    
    class func entityName() -> String {
        return "Pin";
    }
    
    class func insertNewObjectInManagedObjectContext(moc: NSManagedObjectContext ) -> Pin {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName(), inManagedObjectContext: moc) as! Pin
    }

}
