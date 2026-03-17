//
//  NetworkAuth.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

/// Defines authentication strategies for `NetworkEndpoint` requests.

import Foundation

/// Authentication strategy for an HTTP request.
///
/// Used by `NetworkEndpoint` to determine how (or if) credentials are attached
/// to the outgoing `URLRequest`.
public enum NetworkAuth {
    /// No authentication. No additional headers are applied.
    case none
    /// Bearer token authentication.
    ///
    /// Sets `Authorization: Bearer <token>`.
    case bearer(String)
    /// HTTP Basic authentication.
    ///
    /// Encodes `"username:password"` in Base64 and sets
    /// `Authorization: Basic <base64-credentials>`.
    case basic(username: String, password: String)
    /// Custom header-based authentication.
    ///
    /// Sets the provided header key/value on the request.
    case custom(header: String, value: String)
}

