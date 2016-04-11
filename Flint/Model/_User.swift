// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.swift instead.

import Foundation
import CoreData

public enum UserAttributes: String 
{
    case email
    case identifier
    case majors
    case minors
    case name
    case organizations
}

public enum UserRelationships: String
{
    case events
}

public class _User: NSManagedObject 
{

    // MARK: - Properties

    @NSManaged public var email: String

    @NSManaged public var identifier: Int32

    @NSManaged public var majors: [String]

    @NSManaged public var minors: [String]

    @NSManaged public var name: String

    @NSManaged public var organizations: [String]

    // MARK: - Relationships

    @NSManaged public var events: Set<Event>

}

