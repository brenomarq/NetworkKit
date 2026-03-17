//
//  File.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

import Foundation

public enum NetworkErrors: Error {
    case invalidUrl
    case requestFailed(status: Int)
    case decodingError(Error)
    case unknown(Error)
}
