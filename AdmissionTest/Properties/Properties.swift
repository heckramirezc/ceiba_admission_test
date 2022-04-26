//
//  Properties.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import Alamofire

struct Properties
{
    static var isDebug: Bool = false

    private struct Versions {
        static let AdmissionTest = "1.0.0"
    }
    
    struct Messages {
        static let APIError = "Wrong Request"
    }
}

enum EndpointCases: Endpoint {

    case getUsers
    case getPosts(userId: Int)
    
    var httpMethod: HTTPMethod {
        switch self {
            default:
            return HTTPMethod.get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
            default:
            return JSONEncoding.default
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
                return userId != 0 ? "/posts/?userId=\(userId)" : "/posts"
        }
    }
    
    var headers: HTTPHeaders {
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
