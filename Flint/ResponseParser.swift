//
//  ResponseParser.swift
//  Flint
//
//  Created by Riley Testut on 4/11/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import CoreData

public protocol ResponseParser
{
    typealias ParsedObject: NSManagedObject
    
    var managedObjectContext: NSManagedObjectContext { get }
    
    func parsedObjectFromJSONObject(object: [String: AnyObject]) -> ParsedObject
    func parsedObjectsFromJSONArray(array: [[String: AnyObject]]) -> [ParsedObject]
    
    func parsedJSONObjectFromManagedObject(managedObject: ParsedObject) -> [String: AnyObject]
    
    func buildManagedObject(managedObject: ParsedObject, withJSONObject object: [String: AnyObject])
    func buildJSONObjectWithManagedObject(managedObject: ParsedObject) -> [String: AnyObject]
}

public extension ResponseParser
{
    func parsedObjectFromJSONObject(object: [String: AnyObject]) -> ParsedObject
    {
        var parsedObject: ParsedObject! = nil
        
        self.managedObjectContext.performBlockAndWait { 
            parsedObject = ParsedObject.insertIntoManagedObjectContext(self.managedObjectContext)
            self.buildManagedObject(parsedObject, withJSONObject: object)
        }
        
        return parsedObject
    }
    
    func parsedObjectsFromJSONArray(array: [[String: AnyObject]]) -> [ParsedObject]
    {
        var parsedObjects = [ParsedObject]()
        
        for object in array
        {
            let parsedObject = self.parsedObjectFromJSONObject(object)
            parsedObjects.append(parsedObject)
        }
        
        return parsedObjects
    }
    
    func parsedJSONObjectFromManagedObject(managedObject: ParsedObject) -> [String: AnyObject]
    {
        var JSONObject: [String: AnyObject]!
        
        self.managedObjectContext.performBlockAndWait { 
            JSONObject = self.buildJSONObjectWithManagedObject(managedObject)
        }
        
        return JSONObject
    }
}
