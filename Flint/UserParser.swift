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
        user.identifier = Int32(object["id"] as! Int)
        user.name = object["name"] as! String
        user.email = object["email"] as! String
        user.uscID = Int64(object["usc_id"] as! Int)
        
        for major in object["majors"] as! [String]
        {
            user.majors.append(major)
        }
        
        for minor in object["minors"] as! [String]
        {
            user.minors.append(minor)
        }
        
        for organization in object["organizations"] as! [String]
        {
            user.organizations.append(organization)
        }
    }
}