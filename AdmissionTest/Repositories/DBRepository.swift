//
//  DBRepository.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import Foundation
import RealmSwift

class DBRepository: DB {
    var realm: Realm?
    
    func getUsers() -> [User] {
        var users: [User] = []

        let result = realm?.objects(UserEntity.self)
        if ((result != nil) && result!.count > 0) {
            result?.forEach{ usr in
                let geo = Geolocation(lat: usr.address?.geo?.lat,
                                      lng: usr.address?.geo?.lng)
                
                let address = Address(street: usr.address?.street,
                                      suite: usr.address?.suite,
                                      city: usr.address?.city,
                                      zipcode: usr.address?.zipcode,
                                      geo: geo)
                
                let company = Company(name: usr.company?.name,
                                      catchPhrase: usr.company?.catchPhrase,
                                      bs: usr.company?.bs)
                
                let user = User(id: usr.id,
                                name: usr.name,
                                username: usr.username,
                                email: usr.email,
                                address: address,
                                phone: usr.phone,
                                website: usr.website,
                                company: company )
                
                users.append(user)
            }
        }
        
        return users
    }
    
    func getPosts(id: Int) -> [Post] {
        var posts: [Post] = []
        let result = realm?.objects(PostsEntity.self).filter("userId = %@", id)
        
        if ((result != nil) && result!.count > 0) {
            result?.forEach{ pst in
                let post = Post(userId: pst.userId, id: pst.id, title: pst.title, body: pst.body)
                posts.append(post)
            }
        }
        
        return posts
    }
    
    func setUsers(users: [User]) {
        try! realm?.write {
            users.forEach { usr in
                let geo = GeolocationEntity()
                geo.lat = usr.address?.geo?.lat ?? ""
                geo.lng = usr.address?.geo?.lng ?? ""
                
                let address = AddressEntity()
                address.street = usr.address?.street ?? ""
                address.suite = usr.address?.suite ?? ""
                address.city = usr.address?.city ?? ""
                address.zipcode = usr.address?.zipcode ?? ""
                address.geo = geo
                
                let company = CompanyEntity()
                company.name = usr.company?.name ?? ""
                company.catchPhrase = usr.company?.catchPhrase ?? ""
                company.bs = usr.company?.bs ?? ""
                
                let user = UserEntity()
                user.id = usr.id ?? 0
                user.name = usr.name ?? ""
                user.username = usr.username ?? ""
                user.email = usr.email ?? ""
                user.address = address
                user.phone = usr.phone ?? ""
                user.website = usr.website ?? ""
                user.company = company
                
                realm?.add(user)
            }
        }
    }
    
    func setPosts(posts: [Post]) {
        try! realm?.write {
            posts.forEach { pst in
                let post = PostsEntity()
                post.id = pst.id ?? 0
                post.userId = pst.userId ?? 0
                post.title = pst.title ?? ""
                post.body = pst.body ?? ""
                
                realm?.add(post)
            }
        }
    }
}
