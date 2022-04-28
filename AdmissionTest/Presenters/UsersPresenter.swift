//
//  UsersPresenter.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

class UsersPresenter: UsersPresenterable {
    var users: [User]?
    
    var router: UsersRouterable?
    var interactor: UsersInteractorable? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: UsersViewable?
    
    func asignPosts() async {
        var items: [[FeedItem]] = []
        let entities: [User] = try! await self.users!.parallelMap(parallelism: 4) { u in
            var user = u
            user.avatar = Int.random(in: 1..<6)
            if (u.posts == nil || u.posts?.count == 0) {
                user.posts = await self.interactor!.getPosts(id: u.id!)
            }
           return user
         }
        view?.updateEntity(users: entities)
        
        entities.forEach{entity in
            var _item:[FeedItem] = [
                .posts(entity.posts?.count ?? 0),
            ]
            entity.posts?.forEach{postEntity in
                _item.append(.post(postEntity))
            }
            items.append(_item)
        }
        view?.setData(items: items)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view?.reloadCollection()
            self.view?.dismiss(animated: true)
        }
    }
    
    func onSuccess(entities: [User]) {
        self.users = entities
        for (index, _) in self.users!.enumerated() {
            let posts = interactor!.getLocalPosts(id: self.users![index].id!)
            self.users![index].posts = posts
        }
        Task {
            await self.asignPosts()
        }
    }
    
    func onError(error: String) {
    }
}
