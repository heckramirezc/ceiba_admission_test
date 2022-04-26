//
//  PostsEntity.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

struct Post: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

extension Post {
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}
