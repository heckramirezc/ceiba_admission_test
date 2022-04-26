//
//  PostsViewable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import Foundation

protocol PostsViewable: Viewable {
    var presenter: PostsPresenterable? { get set }
}
