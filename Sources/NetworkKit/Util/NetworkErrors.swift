//
//  File.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

import Foundation

public enum NetworkErrors: Error {
    case invalidUrl
    case noResponse
    case requestFailed(status: Int)
    case unexpectedStatus(code: Int)
    case unauthorized
    case forbidden
    case notFound
    case badRequest
    case internalServerError
    case decodingError(Error)
    case unknown(Error)
}
