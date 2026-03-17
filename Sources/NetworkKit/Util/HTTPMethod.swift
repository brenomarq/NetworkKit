//
//  HTTPMethod.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

/// Defines supported HTTP methods for `NetworkEndpoint` requests.

import Foundation

/// Standard HTTP methods.
///
/// The raw value corresponds to the uppercase method string used in `URLRequest.httpMethod`.
public enum HTTPMethod: String {
    /// Retrieves a resource without side effects.
    case get = "GET"
    /// Creates a resource or submits data to the server.
    case post = "POST"
    /// Partially updates a resource.
    case patch = "PATCH"
    /// Creates or fully replaces a resource.
    case put = "PUT"
    /// Deletes a resource.
    case delete = "DELETE"
}
