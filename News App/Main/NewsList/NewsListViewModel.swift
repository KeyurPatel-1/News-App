//
//  NewsListViewModel.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation
import Combine

class NewsListViewModel: ObservableObject {

    enum ViewType {
        case list
        case grid
    }

    @Published var newsList: [NewsListModel.Article]
    @Published var searchText: String
    @Published var isFetchingFromServer: Bool
    @Published var selectedViewType: ViewType

    private var totalResult: Int?
    private var currentPage: Int
    private var cancellables = Set<AnyCancellable>()

    private var dataFetcher: DataFetcher

    init(dataFetcher: DataFetcher? = nil) {
        self.newsList = []
        self.searchText = ""
        self.currentPage = 1
        self.isFetchingFromServer = false
        self.selectedViewType = .list
        self.dataFetcher = dataFetcher ?? NewsListDataFetcher(requestModel: .init())
        self.setupSearch()
    }

    func onAppear() {
        self.fetchNewsList()
    }

    func setupSearch() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }
                self.onSearch()
            }
            .store(in: &cancellables)
    }

    func fetchNewsList(isFromRefresh: Bool = false) {
        if !isFromRefresh {
            self.isFetchingFromServer = true
        }

        if var fetcher = self.dataFetcher as? NewsListDataFetcher {
            fetcher.updateRequestModel(.init(
                q: self.searchText,
                language: "en",
                pageSize: self.pageSize,
                page: self.currentPage
            ))
            self.dataFetcher = fetcher
        }

        Task {
            do {
                guard let response = try await dataFetcher.fetch() as? NewsListModel else {
                    return
                }
                
                await MainActor.run {
                    self.isFetchingFromServer = false
                    self.totalResult = response.totalResults
                    let newsArray = response.articles ?? []
                    if self.currentPage == 1 {
                        self.newsList = newsArray
                    } else {
                        self.newsList.append(contentsOf: newsArray)
                    }

                }
            } catch {
                print(error)
                await MainActor.run {
                    self.isFetchingFromServer = false
                }
            }
        }
    }

    func onSearch() {
        self.currentPage = 1
        self.fetchNewsList()
    }

    func onRefresh() {
        self.currentPage = 1
        self.fetchNewsList(isFromRefresh: true)
    }

    func loadMoreNews() {
        if !self.newsList.isEmpty && self.totalResult ?? 0 > self.newsList.count {
            self.currentPage += 1
            self.fetchNewsList()
        }

    }

    func onChangeViewType(_ type: ViewType) {
        self.selectedViewType = type
    }
}

extension NewsListViewModel {

    var pageSize: Int {
        20
    }

    var isEmptyList: Bool {
        self.newsList.isEmpty
    }
}
