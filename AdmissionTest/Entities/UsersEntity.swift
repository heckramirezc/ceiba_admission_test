//
//  UsersEntity.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

struct User: Codable {
    let id: Int?
    let name: String?
}

extension User {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
