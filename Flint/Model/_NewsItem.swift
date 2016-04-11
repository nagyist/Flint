// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NewsItem.swift instead.

import Foundation
import CoreData

public enum NewsItemAttributes: String 
{
    case date
    case identifier
    case itemDescription
    case name
}

public enum NewsItemRelationships: String
{
    case committees
}

public class _NewsItem: NSManagedObject 
{

    // MARK: - Properties

    @NSManaged public var date: NSDate

    @NSManaged public var identifier: Int32

    @NSManaged public var itemDescription: String

    @NSManaged public var name: String

    // MARK: - Relationships

    @NSManaged public var committees: Set<Committee>

}

