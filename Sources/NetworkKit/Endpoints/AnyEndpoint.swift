//
//  AnyEndpoint.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

/// A type-erased `NetworkEndpoint` for constructing requests without defining a dedicated type.

import Foundation

/// A concrete, type-erased endpoint.
///
/// Use `AnyEndpoint` to quickly describe an HTTP request when creating a dedicated
/// endpoint type would be unnecessary. It conforms to `NetworkEndpoint` and exposes
/// the standard components used to build a `URLRequest`.
public struct AnyEndpoint: NetworkEndpoint {
    /// The base service URL (e.g., https://api.example.com).
    public let baseUrl: URL
    /// The path to append to `baseUrl` (e.g., "/v1/users").
    public let path: String
    /// The HTTP method for the request.
    public let method: HTTPMethod
    /// An optional encodable request body.
    public let body: Encodable?
    /// Additional HTTP headers.
    public let headers: [String : String]
    /// The authentication strategy for this request.
    public let auth: NetworkAuth
    
    /// Creates a new endpoint description.
    ///
    /// - Parameters:
    ///   - baseUrl: The base service URL.
    ///   - path: The path to append to `baseUrl`.
    ///   - method: The HTTP method. Defaults to `.get`.
    ///   - body: An optional encodable body. Defaults to `nil`.
    ///   - headers: Additional HTTP headers. Defaults to an empty dictionary.
    ///   - auth: The authentication strategy. Defaults to `.none`.
    public init(
        baseUrl: URL,
        path: String,
        method: HTTPMethod = .get,
        body: Encodable? = nil,
        headers: [String : String] = [:],
        auth: NetworkAuth = .none
    ) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.body = body
        self.headers = headers
        self.auth = auth
    }
}

