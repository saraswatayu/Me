//
//  Picture.swift
//  Virtual Tourist
//
//  Created by Ayush Saraswat on 12/20/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

import UIKit
import CoreData

func mySharedSession() -> (NSURLSession)
{
    var session : NSURLSession! = nil
    var onceToken = dispatch_once_t()
    dispatch_once(&onceToken, { () -> Void in
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPMaximumConnectionsPerHost = 1
        session = NSURLSession(configuration: configuration)

    })

    return session
}

class Picture: NSManagedObject {

    @NSManaged var identifier: String
    @NSManaged var url: String
    @NSManaged var hasBeenDownloaded: Bool
    @NSManaged var pin: Pin
    
    var image : UIImage? {
        
        get {
            return Caches.imageCache.imageWithIdentifier(identifier)
        }
        set {
            Caches.imageCache.storeImage(newValue, withIdentifier: identifier)
        }
    
    }
    
    class func entityName() -> String {
        return "Picture";
    }
    
    class func insertNewObjectInManagedObjectContext(moc: NSManagedObjectContext) -> Picture {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName(), inManagedObjectContext: moc) as! Picture
    }
    
    class func insertNewObjectForDictionary(dictionary: [String: AnyObject], inContext moc: NSManagedObjectContext ) -> Picture {
        
        let picture = insertNewObjectInManagedObjectContext(moc)

        // URL Format is https: // farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

        let id : AnyObject = dictionary["id"]!
        let farm_id : AnyObject = dictionary["farm"]!
        let server_id : AnyObject = dictionary["server"]!
        let secret : AnyObject = dictionary["secret"]!

        picture.url = "https://farm\(farm_id).staticflickr.com/\(server_id)/\(id)_\(secret).jpg"

        picture.identifier = id as! String
        picture.hasBeenDownloaded = false
        
        return picture
    }
    
    // MARK: - Prepare for Deletion
    
    override func prepareForDeletion() {
        super.prepareForDeletion()

        // Setting image to nil removes the file from documents directory
        image = nil
    }
    
    // MARK: - Image Cache
    
    private struct Caches {
        static let imageCache = ImageCache()
    }
}
