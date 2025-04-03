//
//  NewsDetailsViewModel.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation

class NewsDetailsViewModel: ObservableObject {

    @Published var newsDetails: NewsListModel.Article

    init(newsDetails: NewsListModel.Article) {
        self.newsDetails = newsDetails
    }
}
