//
//  PostsPresenterable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import Foundation

protocol PostsPresenterable {
    var router: PostsRouterable? { get set }
    var interactor: PostsInteractorable? { get set }
    var view: PostsViewable? { get set }
    
    func onSuccess(entities: [Post])
    func onError(error: String)
}
