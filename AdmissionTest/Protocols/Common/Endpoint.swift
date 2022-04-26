//
//  Endpoint.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import Alamofire

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var url: String {
        return baseURLString + path
    }
}
