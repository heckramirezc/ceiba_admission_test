//
//  UsersRouter.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import UIKit

class UsersRouter: Routerable {
    private(set) weak var view: ViewEntry!
    
    static func start() -> Routerable {
        let router = UsersRouter()
        
        let view = UsersViewController()
        let presenter = UsersPresenter()
        let interactor = UsersInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.view = view
        return router
    }
}
