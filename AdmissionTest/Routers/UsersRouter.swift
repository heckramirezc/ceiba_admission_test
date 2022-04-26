//
//  UsersRouter.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import UIKit

class UsersRouter: UsersRouterable {
    private(set) weak var view: ViewEntry!
    
    static func start() -> UsersRouterable {
        let router = UsersRouter()
        
        let view: UsersViewable = UsersViewController()
        var presenter: UsersPresenterable = UsersPresenter()
        var interactor: UsersInteractorable = UsersInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.api = APIRepository()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.view = view as? ViewEntry
        return router
    }
}
