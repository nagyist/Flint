//
//  NSDateFormatter+ISO8601.swift
//  Flint
//
//  Created by Riley Testut on 4/11/16.
//  Copyright © 2016 Spark SC. All rights reserved.
//

import Foundation

extension NSDateFormatter
{
    class func ISO8601DateFormatter() -> NSDateFormatter
    {        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return dateFormatter
    }
}