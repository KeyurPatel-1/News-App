//
//  NetworkManager.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared: NetworkManagerProtocol = NetworkManager()
    private let session: URLSession

    private init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["X-Api-Key": AppConstant.APIKEY]
        self.session = URLSession(configuration: config)
    }

    func request<T: Decodable, U: Encodable>(
        url: APIEndpoints,
        method: HTTPMethod = .GET,
        requestBody: U? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {

        guard var components = URLComponents(string: url.urlString) else {
            throw NetworkError.invalidURL
        }

        if (method == .GET || method == .DELETE), let body = requestBody {
            let jsonData = try JSONEncoder().encode(body)
            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                components.queryItems = jsonDict.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
        }

        guard let finalURL = components.url else { throw NetworkError.invalidURL }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if (method == .POST || method == .PUT), let body = requestBody {
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
