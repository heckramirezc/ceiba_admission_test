//
//  AdmissionTestTests.swift
//  AdmissionTestTests
//
//  Created by Heck Ramírez on 25/04/22.
//

import XCTest
@testable import AdmissionTest

class AdmissionTestTests: XCTestCase {
    var userViewController: UsersViewController!
    var userRouter: UsersRouter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func setUp() {
        self.userRouter = (UsersRouter.start() as! UsersRouter)
        self.userViewController = (self.userRouter.view as! UsersViewController)
    }
    
    func testReloadCollection() {
        userViewController.reloadCollection()
    }
    
    func testSetData() {
        let items: [[FeedItem]] = [
            [
                .posts(1),
                .post(Post(userId: 1,
                           id: 1,
                           title: "Titulo",
                           body: "Contenido")
                )
                
            ],
        ]
        userViewController.setData(items: items)
        XCTAssert(userViewController.items.count > 0)
    }
    
    func testUpdateEntity() {
        let users: [User] = [User(id: 1,
                                  name: "Hector Ramírez",
                                  username: "heckramirezc",
                                  email: "heckramirezc@aol.com",
                                  address: Address(
                                    street: "Calle",
                                    suite: "Guatemala",
                                    city: "Ciudad",
                                    zipcode: "01001",
                                    geo: Geolocation(lat: "0",
                                                     lng: "0")),
                                  phone: "50255691414",
                                  website: "heckramirezc.com",
                                  company: Company(name: "Ceiba Software",
                                                   catchPhrase: "A",
                                                   bs: "B")
                                 )
                            ]
        userViewController.updateEntity(users: users)
        XCTAssert(userViewController.users!.count > 0)
    }
    
    func testGetUsersAPI() {
        DispatchQueue.main.async { [weak self] in
            self!.userViewController.presenter?.interactor?.getUsers()
            XCTAssert(self!.userViewController.presenter?.users != nil
                      && (self!.userViewController.presenter?.users!.count)! > 0)
        }

        
    }
    
    func testGetPostsAPI() async {
        let posts:[Post] = await userViewController.presenter?.interactor?.getPosts(id: 1) as? [Post] ?? []
        XCTAssert(posts.count > 0)
    }
    
    func testSetPostsDB() {
        DispatchQueue.main.async { [weak self] in
            let posts: [Post] = [Post(userId: 1,
                                      id: 1,
                                      title: "Titulo",
                                      body: "Contenido")]
            self?.userViewController.presenter?.interactor?.db?.setPosts(posts: posts)
            
            let postsDB = self?.userViewController.presenter?.interactor?.getLocalPosts(id: 1)
            XCTAssert(((postsDB != nil)
                       && postsDB!.count > 0))
        }
    }
    
    func testSetUsersDB() {
        DispatchQueue.main.async { [weak self] in
            let users: [User] = [User(id: 1,
                                      name: "Hector Ramírez",
                                      username: "heckramirezc",
                                      email: "heckramirezc@aol.com",
                                      address: Address(
                                        street: "Calle",
                                        suite: "Guatemala",
                                        city: "Ciudad",
                                        zipcode: "01001",
                                        geo: Geolocation(lat: "0",
                                                         lng: "0")),
                                      phone: "50255691414",
                                      website: "heckramirezc.com",
                                      company: Company(name: "Ceiba Software",
                                                       catchPhrase: "A",
                                                       bs: "B")
                                     )]
            self?.userViewController.presenter?.interactor?.db?.setUsers(users: users)
            
            let usersDB = self?.userViewController.presenter?.interactor?.db?.getUsers()
            XCTAssert(((usersDB != nil)
                       && usersDB!.count > 0))
        }
    }
    
    func testGetPostsDB() async {
        let _ = await userViewController.presenter?.interactor?.getPosts(id: 1)
        DispatchQueue.main.async { [weak self] in
            let postsDB = self?.userViewController.presenter?.interactor?.getLocalPosts(id: 1)
            XCTAssert(((postsDB != nil)
                       && postsDB!.count > 0))
        }
    }
    
    func testSearch() {
        DispatchQueue.main.async { [weak self] in
            self!.userViewController.presenter?.interactor?.getUsers()
            self!.userViewController.searchBar?.text = "Leanne"
            XCTAssert(self!.userViewController.items.count > 0)
        }
    }
    
    func testSearchMock() {
        let users: [User] = [User(id: 1,
                                  name: "Hector Ramírez",
                                  username: "heckramirezc",
                                  email: "heckramirezc@aol.com",
                                  address: Address(
                                    street: "Calle",
                                    suite: "Guatemala",
                                    city: "Ciudad",
                                    zipcode: "01001",
                                    geo: Geolocation(lat: "0",
                                                     lng: "0")),
                                  phone: "50255691414",
                                  website: "heckramirezc.com",
                                  company: Company(name: "Ceiba Software",
                                                   catchPhrase: "A",
                                                   bs: "B")
                                 )]
        userViewController.updateEntity(users: users)
        let items: [[FeedItem]] = [
            [
                .posts(1),
                .post(Post(userId: 1,
                           id: 1,
                           title: "Titulo",
                           body: "Contenido")
                )
                
            ],
        ]
        userViewController.setData(items: items)
        
        userViewController.searchBar?.text = "Hector"
        debugPrint(userViewController.items)
        XCTAssert(userViewController.items.count > 0)
    }
    
    func testEmptySearch() {
        userViewController.searchBar?.text = "Hector"
        XCTAssert(userViewController.items.count == 0)
    }
    
    func testSetPostsAPI() async {
        let _ = await userViewController.presenter?.interactor?.getPosts(id: 1)
        DispatchQueue.main.async { [weak self] in
            let postsDB = self?.userViewController.presenter?.interactor?.db?.getPosts(id: 1)
            XCTAssert((postsDB != nil)
                      && postsDB!.count > 0)
        }
    }
}
