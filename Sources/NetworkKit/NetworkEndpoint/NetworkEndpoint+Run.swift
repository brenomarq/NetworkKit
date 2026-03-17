//
//  NetworkEndpoint+Run.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

import Foundation

public extension NetworkEndpoint {
    func run<T: Decodable>(
        session: URLSession = .shared,
        decoder: JSONDecoder = .init()
    ) async throws -> T {
        let request = try createRequest()
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkErrors.noResponse
        }
        
        try check(status: httpResponse.statusCode)
        
        return try decoder.decode(T.self, from: data)
    }
    
    func run(session: URLSession = .shared) async throws -> Data {
        let request = try createRequest()
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkErrors.noResponse
        }
        
        try check(status: httpResponse.statusCode)
        
        return data
    }
}

public extension NetworkEndpoint {
    private func createRequest() throws -> URLRequest {
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        if let body = body { request.httpBody = try JSONEncoder().encode(body) }
        
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        applyAuth(to: &request)
        
        return request
    }
    
    private func check(status: Int) throws {
        switch status {
        case 200..<300:
            break
        case 401:
            throw NetworkErrors.unauthorized
        case 403:
            throw NetworkErrors.forbidden
        case 404:
            throw NetworkErrors.notFound
        case 400..<500:
            throw NetworkErrors.badRequest
        case 500..<600:
            throw NetworkErrors.internalServerError
        default:
            throw NetworkErrors.unexpectedStatus(code: status)
        }
    }
}
