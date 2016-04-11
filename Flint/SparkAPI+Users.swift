//
//  SparkAPI+Users.swift
//  Flint
//
//  Created by Riley Testut on 4/11/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import Alamofire

public extension SparkAPI
{
    func fetchUsersWithCompletion(completion: ([User]?, NSError?) -> Void)
    {
        // Constructs the URL for this request
        let URL = self.baseURL + "/users"
        
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
            let parser = UserParser(managedObjectContext: managedObjectContext)
            
            // Parse the JSON into User objects
            let users = parser.parsedObjectsFromJSONArray(JSON)
            
            // Always make sure to call callback from within a performBlock to ensure Core Data doesn't get mad at us
            managedObjectContext.performBlock({
                
                // Return the parsed users to the user via the callback closure
                completion(users, nil)
            })
        }
    }
    
    func fetchUsersWithIdentifiers(identifiers: Set<Int>, completion: ([User]?, NSError?) -> Void)
    {
        let URL = self.baseURL + "/users"
        
        Alamofire.request(.GET, URL, parameters: ["id": Array(identifiers)], encoding: .URL, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [[String: AnyObject]] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = UserParser(managedObjectContext: managedObjectContext)
            
            let users = parser.parsedObjectsFromJSONArray(JSON)
            
            managedObjectContext.performBlock({
                completion(users, nil)
            })
            
        }
    }
    
    func addUser(user: User, completion: (User?, NSError?) -> Void)
    {
        let URL = self.baseURL + "/users"
        
        let parser = UserParser(managedObjectContext: user.managedObjectContext!)
        let parameters = parser.parsedJSONObjectFromManagedObject(user)
        
        Alamofire.request(.POST, URL, parameters: parameters, encoding: .JSON, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [String: AnyObject] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = UserParser(managedObjectContext: managedObjectContext)
            
            let user = parser.parsedObjectFromJSONObject(JSON)
            
            managedObjectContext.performBlock({
                completion(user, nil)
            })
            
        }
    }
    
    func removeUser(user: User, completion: (Bool, NSError?) -> Void)
    {
        var identifier: Int32! = nil
        
        user.managedObjectContext?.performBlockAndWait({
            identifier = user.identifier
        })
        
        let URL = self.baseURL + "/users/" + String(identifier)
        
        Alamofire.request(.DELETE, URL).validate().response { (request, response, data, error) in
            completion(error == nil, error)
        }
    }
    
    func updateUser(user: User, completion: (User?, NSError?) -> Void)
    {
        var identifier: Int32! = nil
        
        user.managedObjectContext?.performBlockAndWait({
            identifier = user.identifier
        })
        
        let URL = self.baseURL + "/users/" + String(identifier)
        
        let parser = UserParser(managedObjectContext: user.managedObjectContext!)
        let parameters = parser.parsedJSONObjectFromManagedObject(user)
        
        Alamofire.request(.PUT, URL, parameters: parameters, encoding: .JSON, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [String: AnyObject] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = UserParser(managedObjectContext: managedObjectContext)
            
            let user = parser.parsedObjectFromJSONObject(JSON)
            
            managedObjectContext.performBlock({
                completion(user, nil)
            })
            
        }
        
    }
}