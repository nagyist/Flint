//
//  SparkAPI.swift
//  Flint
//
//  Created by Matias Franco on 3/7/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation
import Alamofire

public class SparkAPI
{
    public static let sharedAPI = SparkAPI();
    
    private let baseURL = NSURL(string: "http://199.19.85.8:3000")!
    
    private init()
    {
        
    }
}