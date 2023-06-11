//
//  DateUtils.swift
//  todo
//
//  Created by Pascal Bothner on 27.05.23.
//

import Foundation

struct DateUtils {
    static func getGermanDateFormat(date: Date, includeTime: Bool) -> String {
        let germanDateFormatter = DateFormatter()
        germanDateFormatter.dateFormat = includeTime ? "d.M.yyyy HH:mm:ss" : "d.M.yyyy"
        germanDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return germanDateFormatter.string(from: date)
    }
}
