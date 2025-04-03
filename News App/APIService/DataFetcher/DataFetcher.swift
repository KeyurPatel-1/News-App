//
//  DataFetcher.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation

protocol DataFetcherResponse {}

protocol DataFetcher {
    func fetch() async throws -> DataFetcherResponse
}
