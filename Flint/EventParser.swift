//
//  EventParser.swift
//  Flint
//
//  Created by Matias Franco on 4/11/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import CoreData

public class EventParser: ResponseParser
{
    public let managedObjectContext: NSManagedObjectContext
    
    private let dateFormatter = NSDateFormatter.ISO8601DateFormatter()

    public init(managedObjectContext: NSManagedObjectContext)
    {
        self.managedObjectContext = managedObjectContext
    }

    public func buildManagedObject(event: Event, withJSONObject object: [String : AnyObject]) {
        event.identifier = (object["id"] as! NSNumber).intValue
        event.name = object["name"] as! String
        event.eventDescription = object["description"] as! String
        event.date = self.dateFormatter.dateFromString(object["date"] as! String)!
        event.location = object["location"] as! String
        
        //still needs attendees and committees
        
    }
    
    public func buildJSONObjectWithManagedObject(event: Event) -> [String: AnyObject]
    {
        var object = [String: AnyObject]()
        
        object["id"] = NSNumber(int: event.identifier)
        object["name"] = event.name
        object["description"] = event.eventDescription
        object["date"] = self.dateFormatter.stringFromDate(event.date)
        object["location"] = event.location
        
        return object
    }

}