//
//  API.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import Alamofire

protocol API {
    func getUsers(endpoint: Endpoint, completion: @escaping (AFDataResponse<Data?>?, Error?) -> ())
    func getPosts(endpoint: Endpoint, completion: @escaping (AFDataResponse<Data?>?, Error?) -> ())
}
