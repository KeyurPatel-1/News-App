//
//  RequestModel.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

struct NewsListRequestModel: Codable {
    var q: String?
    var language: String?
    var sources: String?
    var from: String?
    var to: String?
    var sortBy: String?
    var pageSize: Int?
    var page: Int?
}
