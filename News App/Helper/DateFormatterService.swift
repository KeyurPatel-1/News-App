//
//  DateFormatterService.swift
//  News App
//
//  Created by Keyur Patel on 03/04/25.
//

import Foundation

final class DateFormatterService {

    static let shared = DateFormatterService()
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter
    }()

    private init() {}

    func format(_ dateString: String?, format: DateFormatStyle = .MMMDYYYY) -> String? {
        guard let dateString = dateString, let date = convertToDate(dateString) else {
            return nil
        }

        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }

    private func convertToDate(_ dateString: String) -> Date? {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: dateString)
    }
}


enum DateFormatStyle: String {
    case MMMDYYYY = "MMM d, yyyy"
}
