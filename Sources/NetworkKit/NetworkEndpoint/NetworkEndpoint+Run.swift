//
//  NetworkEndpoint+Run.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

/// Extensions that execute `NetworkEndpoint` requests and decode responses.

import Foundation

/// Execution helpers for performing requests described by `NetworkEndpoint`.
public extension NetworkEndpoint {
    /// Performs the request and decodes the response body into the specified type.
    ///
    /// - Parameters:
    ///   - session: The `URLSession` used to perform the request. Defaults to `.shared`.
    ///   - decoder: The `JSONDecoder` used to decode the response data. Defaults to a new instance.
    /// - Returns: A decoded instance of `T`.
    /// - Throws: `NetworkErrors` for transport or HTTP errors, or a decoding error if parsing fails.
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
    
    /// Performs the request and returns the raw response data.
    ///
    /// - Parameter session: The `URLSession` used to perform the request. Defaults to `.shared`.
    /// - Returns: The response body as `Data`.
    /// - Throws: `NetworkErrors` for transport or HTTP errors.
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

/// Request construction and response validation utilities.
public extension NetworkEndpoint {
    /// Builds a `URLRequest` from the endpoint's components.
    ///
    /// Combines `baseUrl` and `path`, assigns the HTTP method, encodes the optional
    /// `body` as JSON, applies `headers`, and attaches authentication via `applyAuth`.
    /// - Returns: A fully configured `URLRequest` ready to execute.
    /// - Throws: An error if the request body fails to encode.
    private func createRequest() throws -> URLRequest {
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        if let body = body { request.httpBody = try JSONEncoder().encode(body) }
        
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        applyAuth(to: &request)
        
        return request
    }
    
    /// Validates an HTTP status code and throws a corresponding `NetworkErrors` value when needed.
    ///
    /// Accepts 2xx as success and maps common 4xx/5xx codes to specific errors.
    /// - Parameter status: The HTTP status code to evaluate.
    /// - Throws: A specific `NetworkErrors` case for known failures, or `.unexpectedStatus` otherwise.
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
