//
//  SparkAPI.swift
//  Flint
//
//  Created by Matias Franco on 3/7/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import Alamofire

public class SparkAPI
{
    public static let sharedAPI = SparkAPI();
    
    private let baseURL = "http://199.19.85.8:3000"
    
    private init()
    {
    }
}

// Users
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
            
            // Return the parsed users to the user via the callback closure
            completion(users, nil)
        }
    }
}