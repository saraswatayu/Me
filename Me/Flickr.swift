//
//  Flickr.swift
//  Virtual Tourist
//
//  Created by Ayush Saraswat on 12/20/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

import Foundation
import CoreData

class Flickr {
    
    var session: NSURLSession!
    
    init() {
        session = standardSession()
    }
    
    func standardSession() -> NSURLSession {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPMaximumConnectionsPerHost = 5
        return NSURLSession(configuration: configuration)
    }
    
    class func sharedInstance() -> Flickr {
        
        struct Singleton {
            static var sharedInstance = Flickr()
        }
        
        return Singleton.sharedInstance
    }
 
    // MARK: - One Picture
    
    func taskForPictureData(picture: Picture, completionHandler: (data: NSData?, error: NSError?) -> (Void)) -> NSURLSessionDataTask {

        let url = NSURL(string: picture.url)!
        
        
        let task = session.dataTaskWithURL(url) {data, response, error in
            
            if let error = error {
                completionHandler(data: nil, error: error)
            }
                
            else if let data = data {
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandler(data: data, error: nil)
                }
            }
        }
        
        task.resume()
        
        return task
    }
    
    // MARK: - Pictures for Pin
    
    func taskForFetchingPicturesForPin(pin: Pin, page: Int, completionHandler: (results: [[String : AnyObject]]?, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        
        let urlString: String =  "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=86997f23273f5a518b027e2c8c019b0f&lat=\(pin.lat)&lon=\(pin.long)&format=json&nojsoncallback=1&per_page=21&page=\(page)"
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
            
            if let error = error {
                print(error)
                completionHandler(results: nil, error: error)
            }
                
            else if let data = data {
                let responseObject: NSDictionary?
                do {
                    responseObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                    if let responseObject = responseObject {
                        if let photoArray = responseObject.valueForKey("photos")?.valueForKey("photo") as? [[String : AnyObject]] {
                            completionHandler(results: photoArray, error: nil)
                        }
                    }
                } catch let error as NSError {
                    completionHandler(results: nil, error: error)
                }
            }
        })
        
        task.resume()
        
        return task
    }
    
    // MARK: - Cancel
    func cancelAllTasks() {
        session.invalidateAndCancel()
        session = standardSession()
    }
}