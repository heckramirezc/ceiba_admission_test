//
//  UsersRealmEntity.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import RealmSwift

// User model for Realm DB
class UserEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var email = ""
    @objc dynamic var address: AddressEntity?
    @objc dynamic var phone = ""
    @objc dynamic var website = ""
    @objc dynamic var company: CompanyEntity?
}

// Address model for Realm DB
class AddressEntity: Object {
    @objc dynamic var street = ""
    @objc dynamic var suite = ""
    @objc dynamic var city = ""
    @objc dynamic var zipcode = ""
    @objc dynamic var geo: GeolocationEntity?
}

// Geolocation model for Realm DB
class GeolocationEntity: Object {
    @objc dynamic var lat = ""
    @objc dynamic var lng = ""
}

// Company model for Realm DB
class CompanyEntity: Object {
    @objc dynamic var name = ""
    @objc dynamic var catchPhrase = ""
    @objc dynamic var bs = ""
}
