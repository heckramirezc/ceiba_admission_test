//
//  UsersViewable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import Foundation

protocol UsersViewable: Viewable {
    var presenter: UsersPresenterable? { get set }
    func reloadCollection()
    func setData(items: [[FeedItem]])
    func updateEntity(users: [User])
}
