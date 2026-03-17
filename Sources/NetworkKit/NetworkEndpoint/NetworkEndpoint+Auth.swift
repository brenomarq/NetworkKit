//
//  NetworkEndpoint+Auth.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

import Foundation

public extension NetworkEndpoint {
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

