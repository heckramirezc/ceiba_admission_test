//
//  PostsInteractor.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import RealmSwift

class PostsInteractor: PostsInteractorable {
    var presenter: PostsPresenterable?
    var api: API?
    var db: DB? {
        didSet {
            db?.realm = try! Realm()
        }
    }
    
    func getPosts(id: Int) {
        let posts = db?.getPosts(id: id)
        (posts!.count > 0) ? self.presenter?.onSuccess(entities: posts!) : getPostsAPI(id: id)
    }
    
    private func getPostsAPI(id: Int) {
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
                            self.presenter?.onError(error: Properties.Messages.APIError)
                            return;
                        }
                        self.presenter?.onSuccess(entities: posts)
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
}
