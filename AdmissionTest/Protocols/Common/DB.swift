//
//  DB.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import Foundation
import RealmSwift

protocol DB {
    var realm: Realm? { get set }
    
    func getUsers() -> [User]
    func getPosts(id: Int) -> [Post]
    func setUsers(users: [User])
    func setPosts(posts: [Post])
}
