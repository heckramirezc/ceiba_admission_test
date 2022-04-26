//
//  APIRepository.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import Alamofire

struct APIRepository: API {
    func getUsers(endpoint: Endpoint, completion: @escaping (AFDataResponse<Data?>?, Error?) -> ()) {
        AF.request(endpoint.url,
                   method: endpoint.httpMethod,
                   encoding: endpoint.encoding,
                   headers: endpoint.headers)
            .response { response in
            if Properties.isDebug {
                debugPrint(response)
            }
            switch response.result {
                case .success:
                    completion(response, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
            }
        }
    }
    
    func getPosts(endpoint: Endpoint, completion: @escaping (AFDataResponse<Data?>?, Error?) -> ()) {
        AF.request(endpoint.url,
                   method: endpoint.httpMethod,
                   encoding: endpoint.encoding,
                   headers: endpoint.headers)
            .response { response in
            if Properties.isDebug {
                debugPrint(response)
            }
            switch response.result {
                case .success:
                    completion(response, nil)
                    break
                case .failure(let error):
                    completion(nil, error)
                    break
            }
        }
    }
}
