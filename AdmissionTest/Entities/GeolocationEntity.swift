//
//  GeolocationEntity.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

struct Geolocation: Codable {
    let lat: String?
    let lng: String?
}

extension Geolocation {
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
