//
//  UsersInteractorable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

protocol UsersInteractorable: Interactorable {
    var presenter: UsersPresenterable? { get set }
    func getUsers()
    func getLocalPosts(id: Int) -> [Post]
    func getPosts(id: Int) async -> [Post]
}
