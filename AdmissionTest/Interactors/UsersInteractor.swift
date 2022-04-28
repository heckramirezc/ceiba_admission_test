//
//  UsersInteractor.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import RealmSwift

class UsersInteractor: UsersInteractorable {
    var presenter: UsersPresenterable?
    var api: API?
    var db: DB? {
        didSet {
            db?.realm = try! Realm()
        }
    }
    
    func getUsers() {
        DispatchQueue.main.async { [weak self] in
            let users = self!.db?.getUsers()
            (users!.count > 0) ? self!.presenter?.onSuccess(entities: users!) : self!.getUserAPI()
        }
    }
    
    func getLocalPosts(id: Int) -> [Post] {
        return  db?.getPosts(id: id) ?? []
    }
    
    func getPosts(id: Int) async -> [Post] {
        await withCheckedContinuation { getPostsRequest in
            getPostsAPI(id: id) { posts in
                getPostsRequest.resume(returning: posts)
            }
        }
    }
    
    private func getUserAPI() {
        api?.getUsers(endpoint: EndpointCases.getUsers, completion: { [self]result, error  in
            if error != nil {
                self.presenter?.onError(error: Properties.Messages.APIError)
                return
            }

            switch (result?.response?.statusCode)! as Int {
                case 200:
                    do {
                        let users = try JSONDecoder().decode([User].self, from: (result?.data!)!)
                        guard users.count > 0 else {
                            self.presenter?.onError(error: Properties.Messages.APIError)
                            return;
                        }
                        DispatchQueue.main.async { [weak self] in
                            self!.db?.setUsers(users: users)
                        }
                        self.presenter?.onSuccess(entities: users)
                    } catch {
                        self.presenter?.onError(error: Properties.Messages.APIError)
                    }
                    break
                default:
                    self.presenter?.onError(error: Properties.Messages.APIError)
                    break
            }
        })
    }
    
    private func getPostsAPI(id: Int, completion: @escaping ([Post]) -> Void) {
        api?.getUsers(endpoint: EndpointCases.getPosts(userId: id), completion: {result, error  in
            if error != nil {
                self.presenter?.onError(error: Properties.Messages.APIError)
                return
            }
            
            switch (result?.response?.statusCode)! as Int {
                case 200:
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: (result?.data!)!)
                        guard posts.count > 0 else {
                            completion([])
                            return;
                        }
                        DispatchQueue.main.async { [weak self] in
                            self!.db?.setPosts(posts: posts)
                        }
                        completion(posts)
                    } catch {
                        completion([])
                    }
                    break
                default:
                    completion([])
                    break
            }
        })
    }
}
