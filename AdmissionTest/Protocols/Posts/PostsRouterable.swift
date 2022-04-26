//
//  PostsRouterable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import Foundation
import UIKit

typealias ViewPostsEntry = PostsViewable & UIViewController

protocol PostsRouterable {
    var view: ViewPostsEntry! { get }
    static func start() -> PostsRouterable
}
