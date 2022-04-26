//
//  Properties.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

struct Properties
{
    static var isDebug: Bool = true

    private struct Versions {
        static let AdmissionTest = "1.0.0"
    }
}

enum EndpointCases: Endpoint {
    case getUsers
    case getPosts(userId: Int)
    
    var httpMethod: String {
        switch self {
            default:
                return "GET"
        }
    }
    
    var baseURLString: String {
        switch self {
            default:
                return "https://jsonplaceholder.typicode.com"
        }
    }
    
    var path: String {
        switch self {
            case .getUsers:
                return "/users"
            case .getPosts(let userId):
                return userId != 0 ? "/posts/\(userId)" : "/posts"
        }
    }
    
    var headers: [String: Any]? {
        switch self {
            default:
                return ["Content-Type": "application/json",
                        "Accept": "application/json"]
        }
    }
    
    var body: [String : Any]? {
        switch self {
            default:
                return [:]
        }
    }
}
