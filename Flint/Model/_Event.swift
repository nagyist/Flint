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

    @NSManaged public var attendees: NSSet

    @NSManaged public var committees: NSSet

}

extension _Event {

    func addAttendees(objects: NSSet) {
        let mutable = self.attendees.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.attendees = mutable.copy() as! NSSet
    }

    func removeAttendees(objects: NSSet) {
        let mutable = self.attendees.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.attendees = mutable.copy() as! NSSet
    }

    func addAttendeesObject(value: User) {
        let mutable = self.attendees.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.attendees = mutable.copy() as! NSSet
    }

    func removeAttendeesObject(value: User) {
        let mutable = self.attendees.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.attendees = mutable.copy() as! NSSet
    }

}

extension _Event {

    func addCommittees(objects: NSSet) {
        let mutable = self.committees.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.committees = mutable.copy() as! NSSet
    }

    func removeCommittees(objects: NSSet) {
        let mutable = self.committees.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.committees = mutable.copy() as! NSSet
    }

    func addCommitteesObject(value: Committee) {
        let mutable = self.committees.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.committees = mutable.copy() as! NSSet
    }

    func removeCommitteesObject(value: Committee) {
        let mutable = self.committees.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.committees = mutable.copy() as! NSSet
    }

}

