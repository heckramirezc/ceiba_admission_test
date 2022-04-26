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
        let users = db?.getUsers()
        (users!.count > 0) ? self.presenter?.onSuccess(entities: users!) : getUserAPI()
    }
    
    private func getUserAPI(){
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
                        self.db?.setUsers(users: users)
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
}
