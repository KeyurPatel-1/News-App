//
//  NewsListViewModelTests.swift
//  News AppTests
//
//  Created by Keyur Patel on 03/04/25.
//

import XCTest
@testable import News_App

class NewsListViewModelTests: XCTestCase {

    var viewModel: NewsListViewModel!
    var mockFetcher: MockNewsListDataFetcher!

    override func setUp() {
        super.setUp()
        mockFetcher = MockNewsListDataFetcher()
        viewModel = NewsListViewModel(dataFetcher: mockFetcher)
    }

    override func tearDown() {
        viewModel = nil
        mockFetcher = nil
        super.tearDown()
    }

    func testFetchNewsList_Success() async {
        // act
        viewModel.fetchNewsList()

        try? await Task.sleep(nanoseconds: 500_000_000)

        // assert
        XCTAssertGreaterThanOrEqual(viewModel.newsList.count, 1)
        XCTAssertEqual(viewModel.newsList.first?.title, "Title News")
    }

}

