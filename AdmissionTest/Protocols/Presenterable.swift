//
//  Presenterable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

protocol Presenterable {
    var interactor: Interactorable? { get set }
    var router: Routerable? { get set }
    var view: Viewable? { get set }
}
