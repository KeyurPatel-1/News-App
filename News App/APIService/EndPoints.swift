//
//  EndPoints.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation

enum APIEndpoints: String {
    static let baseURL = "https://newsapi.org/v2"

    case topHeadlines = "/top-headlines"
    case everything = "/everything"

    var urlString: String {
        return APIEndpoints.baseURL + self.rawValue
    }
}
