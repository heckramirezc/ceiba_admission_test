//
//  Interactorable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

protocol Interactorable {
    var api: API? { get set }
    var db: DB? { get set }
}
