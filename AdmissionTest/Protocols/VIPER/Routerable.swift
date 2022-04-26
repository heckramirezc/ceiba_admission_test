//
//  Routerable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import UIKit

typealias ViewableEntry = Viewable & UIViewController

protocol Routerable {
    var view: ViewableEntry! { get }
    
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, completion: @escaping (() -> Void))
    func pop(animated: Bool)
}

extension Routerable {
    func dismiss(animated: Bool) {
        view.dismiss(animated: animated)
    }
    func dismiss(animated: Bool, completion: @escaping (() -> Void)) {
        view.dismiss(animated: animated, _completion: completion)
    }

    func pop(animated: Bool) {
        view.pop(animated: animated)
    }
}
