# NetworkKit

A lightweight, type-safe networking layer for Swift, designed to simplify API requests while remaining flexible and extensible.

---

## ✨ Features

* Type-safe API requests
* Support for `Codable` models
* Simple request building
* Flexible endpoint abstraction
* Support for raw `Data` and decoded responses
* Authentication support

---

## 📦 Installation (Swift Package Manager)

Follow these steps to integrate this library into your Xcode project:

1. Open your Xcode Project
2. Navigate to the menu File > Swift Packages > Add Package Dependency....
3. Enter the following URL of this repository: https://github.com/brenomarq/NetworkKit.git.
4. Click Next and select the version or branch you want to use.
5. Click Next and then Finish.

---

## 🚀 Quick Start (Recommended: AnyEndpoint)

`AnyEndpoint` is the easiest way to create requests without creating custom enums or structs.

```swift
let endpoint = AnyEndpoint(
    baseUrl: URL(string: "https://jsonplaceholder.typicode.com")!,
    path: "/users"
)

let users: [User] = try await endpoint.run()
```

### With HTTP Method and Body

```swift
let newUser = User(name: "Breno")

let endpoint = AnyEndpoint(
    baseUrl: URL(string: "https://jsonplaceholder.typicode.com")!,
    path: "/users",
    method: .post,
    body: newUser
)

let createdUser: User = try await endpoint.run()
```

---

## 📥 Handling Responses

### Decode JSON

```swift
let users: [User] = try await endpoint.run()
```

### Raw Data (Images, Files)

```swift
let data = try await endpoint.run()
```

---

## 🔐 Authentication

```swift
let endpoint = AnyEndpoint(
    baseUrl: baseURL,
    path: "/users",
    headers: ["Authorization": "Bearer token"]
)
```

Or using `NetworkAuth` (if integrated into request building):

```swift
var auth: NetworkAuth { .bearer("token") }
```

---

## 🧱 Custom Endpoint with Struct

You can conform to `NetworkEndpoint` for more control.

```swift
struct GetUsers: NetworkEndpoint {
    var baseUrl: URL { URL(string: "https://jsonplaceholder.typicode.com")! }
    var path: String { "/users" }
    var method: HTTPMethod { .get }
}

let users: [User] = try await GetUsers().run()
```

---

## 🧩 Custom Endpoint with Enum

Enums are great for grouping related endpoints.

```swift
enum UserEndpoints: NetworkEndpoint {
    case getUsers
    case getUser(id: String)

    var baseUrl: URL {
        URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getUser(let id):
            return "/users/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUsers, .getUser:
            return .get
        }
    }
}

let users: [User] = try await UserEndpoints.getUsers.run()
```

---

## ⚙️ Advanced Usage

### Custom Headers

```swift
struct AuthorizedRequest: NetworkEndpoint {
    var baseUrl: URL { baseURL }
    var path: String { "/secure" }
    var method: HTTPMethod { .get }

    var headers: [String : String] {
        ["Authorization": "Bearer token"]
    }
}
```

---

## 🧪 Example Model

```swift
struct User: Codable {
    let id: Int?
    let name: String
}
```

---

## 🧠 Design Philosophy

NetworkKit is designed with two main usage patterns:

1. **Quick usage (AnyEndpoint / EndPoint)**

   * Minimal boilerplate
   * Fast iteration

2. **Structured usage (Protocol-based)**

   * Scalable
   * Maintainable
   * Better for large codebases

---

## 📌 Notes

* Default `URLSession.shared` is used
* You can inject custom sessions for testing
* Errors are thrown using `NetworkErrors`
