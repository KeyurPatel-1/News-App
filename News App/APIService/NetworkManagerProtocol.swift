//
//  NetworkManagerProtocol.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknownError
}

protocol NetworkManagerProtocol {

    func request<T: Decodable, U: Encodable>(
        url: APIEndpoints,
        method: HTTPMethod,
        requestBody: U?,
        headers: [String: String]?,
        responseType: T.Type
    ) async throws -> T
    
}
