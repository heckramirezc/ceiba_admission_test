//
//  CompanyEntity.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import Foundation

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

extension Company {
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
}

