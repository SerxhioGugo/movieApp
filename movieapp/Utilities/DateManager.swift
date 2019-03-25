//
//  DateManager.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class DateManager: NSObject {
    
    class func methodDateFromString(stringDate:String)->NSDate{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stringDate)
        return date! as NSDate
    }
    
    class func methodStringFromDate(dateFromString:NSDate)->String{
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: dateFromString as Date)
        
        return dateString
        
}
}
