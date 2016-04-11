//
//  UserParser.swift
//  Flint
//
//  Created by Riley Testut on 4/11/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import CoreData

public class UserParser: ResponseParser
{
    public let managedObjectContext: NSManagedObjectContext
    
    public init(managedObjectContext: NSManagedObjectContext)
    {
        self.managedObjectContext = managedObjectContext
    }
    
    public func buildManagedObject(user: User, withJSONObject object: [String : AnyObject])
    {
        user.identifier = (object["id"] as! NSNumber).intValue
        user.name = object["name"] as! String
        user.email = object["email"] as! String
        user.uscID = (object["usc_id"] as! NSNumber).longLongValue
        user.majors = object["majors"] as! [String]
        user.minors = object["minors"] as! [String]
        user.organizations = object["organizations"] as! [String]
    }
    
    public func buildJSONObjectWithManagedObject(user: User) -> [String: AnyObject]
    {
        var object = [String: AnyObject]()
        
        object["id"] = NSNumber(int: user.identifier)
        object["name"] = user.name
        object["email"] = user.email
        object["usc_id"] = NSNumber(longLong: user.uscID)
        object["majors"] = user.majors
        object["minors"] = user.minors
        object["organizations"] = user.organizations
        
        return object
    }
}