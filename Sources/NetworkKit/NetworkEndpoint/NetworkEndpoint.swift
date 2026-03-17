import Foundation

public protocol NetworkEndpoint {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var headers: [String: String] { get }
}

// MARK: Default Values
public extension NetworkEndpoint {
    var body: Encodable? { nil }
    var headers: [String: String] { [:] }
}
