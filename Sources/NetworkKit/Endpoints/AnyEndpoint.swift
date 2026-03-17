//
//  AnyEndpoint.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

import Foundation

public struct AnyEndpoint: NetworkEndpoint {
    public let baseUrl: URL
    public let path: String
    public let method: HTTPMethod
    public let body: Encodable?
    public let headers: [String : String]
    public let auth: NetworkAuth
    
    init(
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

