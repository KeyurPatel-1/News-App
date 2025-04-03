//
//  NewsListDataFetcher.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation

struct NewsListDataFetcher: DataFetcher {

    var requestModel: NewsListRequestModel

    init(requestModel: NewsListRequestModel) {
        self.requestModel = requestModel
    }

    func fetch() async throws -> any DataFetcherResponse {
        return try await NetworkManager.shared
            .request(
                url: .topHeadlines,
                method: .GET,
                requestBody: requestModel,
                headers: nil,
                responseType: NewsListModel.self
            )
    }

    mutating func updateRequestModel(_ model: NewsListRequestModel) {
        self.requestModel = model
    }
}
