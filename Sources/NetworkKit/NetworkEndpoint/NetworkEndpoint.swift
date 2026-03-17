import Foundation

public protocol NetworkEndpoint {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var headers: [String: String] { get }
    var auth: NetworkAuth { get }
}

// MARK: Default Values
public extension NetworkEndpoint {
    var body: Encodable? { nil }
    var headers: [String: String] { [:] }
    var auth: NetworkAuth { .none }
}
