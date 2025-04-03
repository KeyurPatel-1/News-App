//
//  MockNewsListDataFetcher.swift
//  News AppTests
//
//  Created by Keyur Patel on 03/04/25.
//

import Foundation
@testable import News_App

class MockNewsListDataFetcher: DataFetcher {
    var mockResponse: NewsListModel?
    var shouldThrowError = false

    func fetch() async throws -> DataFetcherResponse {
        if shouldThrowError {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
        return mockResponse ?? NewsListModel.init(articles: [.init(author: "Test", content: "Description of the Content", description: "Description", publishedAt: "Today", source: .init(id: "ABC", name: "News Source"), title: "Title News", url: "https://www.google.com", urlToImage: "https://techcrunch.com/wp-content/uploads/2024/05/Minecraft-keyart.jpg?resize=1200,720")], status: "ok", totalResults: 10)
    }
}
