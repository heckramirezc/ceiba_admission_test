//
//  PostsRouter.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

class PostsRouter: Routerable {
    private(set) weak var view: ViewEntry!

    static func start() -> Routerable {
        let router = PostsRouter()
        
        let view = PostsViewController()
        let presenter = PostsPresenter()
        let interactor = PostsInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.view = view
        return router
    }
}
