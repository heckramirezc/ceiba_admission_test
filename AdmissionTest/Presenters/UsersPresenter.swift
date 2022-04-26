//
//  UsersPresenter.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

class UsersPresenter: UsersPresenterable {
    var router: UsersRouterable?
    var interactor: UsersInteractorable? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: UsersViewable?
    
    func onSuccess(entities: [User]) {
        print(entities)
    }
    
    func onError(error: String) {
        print(error)
    }
}
