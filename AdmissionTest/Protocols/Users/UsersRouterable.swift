//
//  UsersRouterable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import Foundation
import UIKit

typealias ViewEntry = UsersViewable & UIViewController

protocol UsersRouterable {
    var view: ViewEntry! { get }
    static func start() -> UsersRouterable
}
