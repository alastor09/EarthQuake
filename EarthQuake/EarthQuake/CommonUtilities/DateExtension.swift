//
//  DateExtension.swift
//  EarthQuake
//
//  Created by Soan Saini on 12/2/17.
//  Copyright © 2017 Soan Saini. All rights reserved.
//

import Foundation

extension Date {
    struct Formatter {
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }()
    }
    var earthQuakeDateString: String { return Formatter.dateFormatter.string(from: self) }
}

extension String{
    var dateFromServerString: Date? {
        return Date.Formatter.dateFormatter.date(from:self)
    }
}
