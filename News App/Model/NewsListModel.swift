//
//  NewsListModel.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation

struct NewsListModel: Codable, DataFetcherResponse {

    let articles : [Article]?
    let status : String?
    let totalResults : Int?

    struct Article : Codable, Hashable, Equatable {
        let author : String?
        let content : String?
        let `description` : String?
        let publishedAt : String?
        let source : Source?
        let title : String?
        let url : String?
        let urlToImage : String?

        static func == (lhs: NewsListModel.Article, rhs: NewsListModel.Article) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(author)
            hasher.combine(content)
            hasher.combine(title)
            hasher.combine(description)
        }
    }

    struct Source : Codable {
        let id : String?
        let name : String?
    }
}
