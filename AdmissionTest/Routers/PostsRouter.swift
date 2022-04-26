//
//  PostsRouter.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

class PostsRouter: PostsRouterable {
    private(set) weak var view: ViewPostsEntry!

    static func start() -> PostsRouterable {
        let router = PostsRouter()
        
        let view: PostsViewable = PostsViewController()
        var presenter: PostsPresenterable = PostsPresenter()
        var interactor: PostsInteractorable = PostsInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.api = APIRepository()
                
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.view = view as? ViewPostsEntry
        return router
    }
}
