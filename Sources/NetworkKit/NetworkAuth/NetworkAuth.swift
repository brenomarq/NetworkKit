//
//  NetworkAuth.swift
//  NetworkKit
//
//  Created by Breno Marques on 17/03/26.
//

import Foundation

public enum NetworkAuth {
    case none
    case bearer(String)
    case basic(username: String, password: String)
    case custom(header: String, value: String)
}
