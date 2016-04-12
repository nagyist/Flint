//
//  CommitteeParser.swift
//  Flint
//
//  Created by Rachit K on 4/11/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import CoreData

public class CommitteeParser: ResponseParser
{
    public let managedObjectContext: NSManagedObjectContext
    
    public init(managedObjectContext: NSManagedObjectContext)
    {
        self.managedObjectContext = managedObjectContext
    }
    
    public func buildManagedObject(committee: Committee, withJSONObject object: [String : AnyObject])
    {
        committee.identifier = (object["id"] as! NSNumber).intValue
        committee.name = object["name"] as! String
        committee.committeeDescription = object["description"] as! String
    }
    
    public func buildJSONObjectWithManagedObject(committee: Committee) -> [String : AnyObject]
    {
        var object = [String: AnyObject]()
        
        object["id"] = NSNumber(int: committee.identifier)
        object["name"] = committee.name
        object["description"] = committee.committeeDescription
        
        return object
    }
}