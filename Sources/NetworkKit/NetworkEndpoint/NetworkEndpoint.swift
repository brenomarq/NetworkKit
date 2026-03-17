/// NetworkEndpoint.swift
///
/// Defines the `NetworkEndpoint` protocol used to describe HTTP requests in a type-safe way.
/// Conforming types provide the core components of a request, including base URL, path,
/// HTTP method, optional body, headers, and authentication requirements.

import Foundation

/// A type that describes a single HTTP endpoint.
///
/// Conforming types encapsulate the information required to build a request,
/// such as the base URL, path, HTTP method, optional request body, headers, and
/// authentication strategy. This abstraction allows request construction and
/// execution to be decoupled, enabling testability and clearer API definitions.
public protocol NetworkEndpoint {
    /// The base URL for the service (e.g., https://api.example.com).
    var baseUrl: URL { get }
    /// The path component to append to `baseUrl` (e.g., "/v1/users").
    var path: String { get }
    /// The HTTP method to use when performing the request.
    var method: HTTPMethod { get }
    /// An optional encodable body to send with the request.
    ///
    /// Implementations may return `nil` for methods that do not send a body
    /// (such as most GET requests).
    var body: Encodable? { get }
    /// Additional HTTP headers to include with the request.
    ///
    /// Header values provided here may be merged with system or client defaults.
    var headers: [String: String] { get }
    /// The authentication strategy required for this endpoint.
    ///
    /// Use `.none` for public endpoints, or specify another case to indicate
    /// token-based or other auth requirements.
    var auth: NetworkAuth { get }
}

// MARK: Default Values

/// Default implementations for optional endpoint components.
///
/// Conformers may override these as needed to provide request bodies, custom
/// headers, or authentication requirements.
public extension NetworkEndpoint {
    /// No request body by default.
    var body: Encodable? { nil }
    /// No additional headers by default.
    var headers: [String: String] { [:] }
    /// No authentication required by default.
    var auth: NetworkAuth { .none }
}
