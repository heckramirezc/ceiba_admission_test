//
//  PostsEntity.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

struct Post: Codable {
    let id: Int?
    let title: String?
}

extension Post {
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}
