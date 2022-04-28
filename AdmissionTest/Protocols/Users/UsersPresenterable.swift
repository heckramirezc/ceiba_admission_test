//
//  UsersPresenterable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

protocol UsersPresenterable {
    var router: UsersRouterable? { get set }
    var interactor: UsersInteractorable? { get set }
    var view: UsersViewable? { get set }
    var users: [User]? { get set }
    
    func onSuccess(entities: [User])
    func onError(error: String)
}
