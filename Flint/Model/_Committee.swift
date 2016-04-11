// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Committee.swift instead.

import Foundation
import CoreData

public enum CommitteeAttributes: String 
{
    case committeeDescription
    case identifier
    case name
}

public enum CommitteeRelationships: String
{
    case events
    case newsItems
}

public class _Committee: NSManagedObject 
{

    // MARK: - Properties

    @NSManaged public var committeeDescription: String

    @NSManaged public var identifier: Int32

    @NSManaged public var name: String

    // MARK: - Relationships

    @NSManaged public var events: Set<Event>

    @NSManaged public var newsItems: Set<NewsItem>

}

