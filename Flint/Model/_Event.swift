// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Event.swift instead.

import Foundation
import CoreData

public enum EventAttributes: String 
{
    case date
    case eventDescription
    case identifier
    case location
    case name
}

public enum EventRelationships: String
{
    case attendees
    case committees
}

public class _Event: NSManagedObject 
{

    // MARK: - Properties

    @NSManaged public var date: NSDate

    @NSManaged public var eventDescription: String

    @NSManaged public var identifier: Int32

    @NSManaged public var location: String

    @NSManaged public var name: String

    // MARK: - Relationships

    @NSManaged public var attendees: Set<User>

    @NSManaged public var committees: Set<Committee>

}

