//
//  PostsRealEntity.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import RealmSwift

// Post model for Realm DB
class PostsEntity: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var body: String?
}
