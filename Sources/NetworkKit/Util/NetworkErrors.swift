//
//  NetworkErrors.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

/// Defines error types used by the networking layer.

import Foundation

/// Errors that can occur when constructing or executing network requests.
///
/// These errors cover invalid request construction, missing or invalid responses,
/// HTTP status failures, decoding issues, and unknown underlying errors.
public enum NetworkErrors: Error {
    /// The composed URL is invalid or could not be formed.
    case invalidUrl
    /// No URL response was received from the server.
    case noResponse
    /// The request failed with the given HTTP status code.
    ///
    /// Prefer more specific cases when available.
    case requestFailed(status: Int)
    /// The server returned a non-success status code that isn't explicitly handled.
    case unexpectedStatus(code: Int)
    /// 401 Unauthorized.
    case unauthorized
    /// 403 Forbidden.
    case forbidden
    /// 404 Not Found.
    case notFound
    /// 400 Bad Request.
    case badRequest
    /// 5xx Server Error.
    case internalServerError
    /// The response could not be decoded into the expected type.
    ///
    /// Carries the underlying decoding error for debugging.
    case decodingError(Error)
    /// An unexpected error occurred.
    ///
    /// Carries the underlying error for additional context.
    case unknown(Error)
}
