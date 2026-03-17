//
//  NetworkEndpoint+Auth.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

/// Extensions that apply authentication to requests built from `NetworkEndpoint`.

import Foundation

/// Authentication helpers for endpoints.
///
/// Provides utilities to attach the appropriate `Authorization` or custom header
/// based on the endpoint's `auth` value.
public extension NetworkEndpoint {
    /// Applies authentication information to the given request.
    ///
    /// Evaluates the endpoint's `auth` configuration and sets the appropriate
    /// HTTP header(s) on the provided `URLRequest`.
    ///
    /// - Parameter request: The request to modify. This parameter is modified in place.
    /// - Note:
    ///   - `.none`: No headers are added.
    ///   - `.bearer(token)`: Sets `Authorization: Bearer <token>`.
    ///   - `.basic(username, password)`: Sets `Authorization: Basic <base64(username:password)>`.
    ///   - `.custom(header, value)`: Sets the provided header key/value.
    internal func applyAuth(to request: inout URLRequest) {
        switch auth {
            
        case .none:
            break
            
        case .bearer(let token):
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
        case .basic(let username, let password):
            let credentials = "\(username):\(password)"
            let base64 = Data(credentials.utf8).base64EncodedString()
            
            request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
            
        case .custom(header: let header, value: let value):
            request.setValue(value, forHTTPHeaderField: header)
        }
    }
}

