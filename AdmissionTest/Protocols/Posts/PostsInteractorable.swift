//
//  PostsInteractorable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

protocol PostsInteractorable: Interactorable {
    var presenter: PostsPresenterable? { get set }
    func getPosts(id: Int)
}
