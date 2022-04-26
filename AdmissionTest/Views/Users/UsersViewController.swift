//
//  UsersViewController.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import UIKit

class UsersViewController: UIViewController, Viewable {
    var presenter: Presenterable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
