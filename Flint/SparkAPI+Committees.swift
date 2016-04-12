//
//  SparkAPI+Committees.swift
//  Flint
//
//  Created by Rachit K on 4/11/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import Alamofire

public extension SparkAPI
{
    func fetchCommitteesWithCompletion(completion: ([Committee]?, NSError?) -> Void)
    {
        let URL = self.baseURL + "/committees"
        
        Alamofire.request(.GET, URL).validate().responseJSON
        {
            response in
            
            guard let JSON = response.result.value as? [[String:AnyObject]] else
            {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = CommitteeParser(managedObjectContext: managedObjectContext)
            
            let committees = parser.parsedObjectsFromJSONArray(JSON)
            
            managedObjectContext.performBlock({
                completion(committees, nil)
            })
        }
    }
    
    func fetchCommitteesWithIdentifiers(identifiers: Set<Int>, completion: ([Committee]?, NSError?) -> Void)
    {
        let URL = self.baseURL + "/committees"
        
        Alamofire.request(.GET, URL, parameters: ["id": Array(identifiers)], encoding: .URL, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [[String: AnyObject]] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = CommitteeParser(managedObjectContext: managedObjectContext)
            
            let committees = parser.parsedObjectsFromJSONArray(JSON)
            
            managedObjectContext.performBlock({
                completion(committees, nil)
            })
            
        }
    }
    
    func addCommittee(committee: Committee, completion: (Committee?, NSError?) -> Void)
    {
        let URL = self.baseURL + "/committees"
        
        let parser = CommitteeParser(managedObjectContext: committee.managedObjectContext!)
        let parameters = parser.parsedJSONObjectFromManagedObject(committee)
        
        Alamofire.request(.POST, URL, parameters: parameters, encoding: .JSON, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [String: AnyObject] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = CommitteeParser(managedObjectContext: managedObjectContext)
            
            let committee = parser.parsedObjectFromJSONObject(JSON)
            
            managedObjectContext.performBlock({
                completion(committee, nil)
            })
            
        }
    }
    
    func removeCommittee(committee: Committee, completion: (Bool, NSError?) -> Void)
    {
        var identifier: Int32! = nil
        
        committee.managedObjectContext?.performBlockAndWait({
            identifier = committee.identifier
        })
        
        let URL = self.baseURL + "/committees/" + String(identifier)
        
        Alamofire.request(.DELETE, URL).validate().response { (request, response, data, error) in
            completion(error == nil, error)
        }
    }
    
    func updateCommittee(committee: Committee, completion: (Committee?, NSError?) -> Void)
    {
        var identifier: Int32! = nil
        
        committee.managedObjectContext?.performBlockAndWait({
            identifier = committee.identifier
        })
        
        let URL = self.baseURL + "/committees/" + String(identifier)
        
        let parser = CommitteeParser(managedObjectContext: committee.managedObjectContext!)
        let parameters = parser.parsedJSONObjectFromManagedObject(committee)
        
        Alamofire.request(.PUT, URL, parameters: parameters, encoding: .JSON, headers: nil).validate().responseJSON { (response) in
            
            guard let JSON = response.result.value as? [String: AnyObject] else {
                completion(nil, response.result.error)
                return
            }
            
            let managedObjectContext = DatabaseManager.sharedManager.backgroundManagedObjectContext()
            
            let parser = CommitteeParser(managedObjectContext: managedObjectContext)
            
            let committee = parser.parsedObjectFromJSONObject(JSON)
            
            managedObjectContext.performBlock({
                completion(committee, nil)
            })
            
        }
        
    }
}