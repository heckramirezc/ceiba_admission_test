//
//  PostsPresenter.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

class PostsPresenter: PostsPresenterable {
    var router: PostsRouterable?
    var interactor: PostsInteractorable? {
        didSet {
            interactor?.getPosts(id: 0)
        }
    }
    var view: PostsViewable?

    func onSuccess(entities: [Post]) {
    }
    
    func onError(error: String) {
    }
}
