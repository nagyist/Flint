//
//  SparkAPI+Events.swift
//  Flint
//
//  Created by Matias Franco on 4/11/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import Alamofire

public extension SparkAPI
{
    func fetchEventsWithCompletion(completion: ([Event]?, NSError?) -> Void)
    {
        // Constructs the URL for this request
        let URL = self.baseURL + "/events"
        
        // Perform a GET request, and receive the response back as JSON
        Alamofire.request(.GET, URL).validate().responseJSON { response in
            
            // Ensures JSON is a non-optional array containing dictionaries.
            // If JSON is nil, then the else block is called, we pass in the error to the callback, and we return from the function
            // If JSON is not nil, then JSON will not be optional, and the rest of the function will continue as normal
            guard let JSON = response.result.value as? [[String: AnyObject]] else {
                completion(nil, response.result.error)
                return
            }
            
            // Create temporary NSManagedObjectContext for the parser to use
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            // Create appropriate parser for this type of data
            let parser = EventParser(managedObjectContext: managedObjectContext)
            
            // Parse the JSON into User objects
            let events = parser.parsedObjectsFromJSONArray(JSON)
            
            // Always make sure to call callback from within a performBlock to ensure Core Data doesn't get mad at us
            managedObjectContext.performBlock({
                
                // Return the parsed users to the user via the callback closure
                completion(events, nil)
            })
        }
    }
    
    func fetchEventsWithIdentifiers(identifiers: Set<Int>, completion: ([Event]?, NSError?) -> Void)
    {
        let URL = self.baseURL + "/events"
        
        Alamofire.request(.GET, URL, parameters: ["id": Array(identifiers)], encoding: .URL, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [[String: AnyObject]] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = EventParser(managedObjectContext: managedObjectContext)
            
            let events = parser.parsedObjectsFromJSONArray(JSON)
            
            managedObjectContext.performBlock({
                completion(events, nil)
            })
            
        }
    }
    
    func addEvent(event: Event, completion: (Event?, NSError?) -> Void)
    {
        let URL = self.baseURL + "/events"
        
        let parser = EventParser(managedObjectContext: event.managedObjectContext!)
        let parameters = parser.parsedJSONObjectFromManagedObject(event)
        
        Alamofire.request(.POST, URL, parameters: parameters, encoding: .JSON, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [String: AnyObject] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = EventParser(managedObjectContext: managedObjectContext)
            
            let event = parser.parsedObjectFromJSONObject(JSON)
            
            managedObjectContext.performBlock({
                completion(event, nil)
            })
            
        }
    }
    
    func removeEvent(event: Event, completion: (Bool, NSError?) -> Void)
    {
        var identifier: Int32! = nil
        
        event.managedObjectContext?.performBlockAndWait({
            identifier = event.identifier
        })
        
        let URL = self.baseURL + "/events/" + String(identifier)
        
        Alamofire.request(.DELETE, URL).validate().response { (request, response, data, error) in
            completion(error == nil, error)
        }
    }
    
    func updateEvent(event: Event, completion: (Event?, NSError?) -> Void)
    {
        var identifier: Int32! = nil
        
        event.managedObjectContext?.performBlockAndWait({
            identifier = event.identifier
        })
        
        let URL = self.baseURL + "/events/" + String(identifier)
        
        let parser = EventParser(managedObjectContext: event.managedObjectContext!)
        let parameters = parser.parsedJSONObjectFromManagedObject(event)
        
        Alamofire.request(.PUT, URL, parameters: parameters, encoding: .JSON, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [String: AnyObject] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = EventParser(managedObjectContext: managedObjectContext)
            
            let event = parser.parsedObjectFromJSONObject(JSON)
            
            managedObjectContext.performBlock({
                completion(event, nil)
            })
            
        }
        
    }


}





