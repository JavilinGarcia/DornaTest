//
//  Date+Extension.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 17/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import Foundation

extension Date {

    static func generateDatesArrayBetweenTwoDates(startDate: Date , endDate:Date) ->[Date] {
        var datesArray: [Date] =  [Date]()
        var startDate = startDate
        let calendar = Calendar.current
        
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        while startDate <= endDate {
            datesArray.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            
        }
        return datesArray
    }
    
    func toStringWithFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let utcTimeZoneStr = dateFormatter.string(from: self)
        
        return utcTimeZoneStr
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMM"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.autoupdatingCurrent
        return dateFormatter.string(from: self).capitalized
    }
    
    static func toDate(str: String, _ format:String?="yyyy-MM-dd") -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date: Date = dateFormatter.date(from: str) {
            return date
        }
        
        return  nil
    }
    
    func dayToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let stringFromDate = formatter.string(from: self)
        
        return stringFromDate
    }
    
    func timeToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let stringFromDate = formatter.string(from: self)
        
        return stringFromDate
    }
    
    func isBetween(startDate:Date, endDate:Date) -> Bool
    {
        return (startDate.compare(self) == .orderedAscending) && (endDate.compare(self) == .orderedDescending)
    }
}
