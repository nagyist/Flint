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

    @NSManaged public var events: NSSet

}

extension _User {

    func addEvents(objects: NSSet) {
        let mutable = self.events.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.events = mutable.copy() as! NSSet
    }

    func removeEvents(objects: NSSet) {
        let mutable = self.events.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.events = mutable.copy() as! NSSet
    }

    func addEventsObject(value: Event) {
        let mutable = self.events.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.events = mutable.copy() as! NSSet
    }

    func removeEventsObject(value: Event) {
        let mutable = self.events.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.events = mutable.copy() as! NSSet
    }

}

