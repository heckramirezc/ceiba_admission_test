//
//  UsersInteractor.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation

class UsersInteractor: UsersInteractorable {
    var presenter: UsersPresenterable?
    var api: API?
    
    func getUsers(){
        api?.getUsers(endpoint: EndpointCases.getUsers, completion: {result, error  in
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
