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

    @NSManaged public var committees: NSSet

}

extension _NewsItem {

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

