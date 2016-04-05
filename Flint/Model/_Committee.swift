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

    @NSManaged public var events: NSSet

    @NSManaged public var newsItems: NSSet

}

extension _Committee {

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

extension _Committee {

    func addNewsItems(objects: NSSet) {
        let mutable = self.newsItems.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.newsItems = mutable.copy() as! NSSet
    }

    func removeNewsItems(objects: NSSet) {
        let mutable = self.newsItems.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.newsItems = mutable.copy() as! NSSet
    }

    func addNewsItemsObject(value: NewsItem) {
        let mutable = self.newsItems.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.newsItems = mutable.copy() as! NSSet
    }

    func removeNewsItemsObject(value: NewsItem) {
        let mutable = self.newsItems.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.newsItems = mutable.copy() as! NSSet
    }

}

