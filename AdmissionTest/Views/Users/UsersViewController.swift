//
//  UsersViewController.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import UIKit

class UsersViewController: UIViewController, UsersViewable {
    var presenter: UsersPresenterable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
