//
//  MVPTestTests.swift
//  MVPTestTests
//
//  Created by Truong Vo on 7/24/17.
//  Copyright © 2017 Truong Vo. All rights reserved.
//

import XCTest
@testable import MVPTest

class UserServiceMock: UserService {
    fileprivate let users: [User]
    
    init (users: [User]) {
        self.users = users
    }
    
    override func getUsers(callBack: @escaping ([User]) -> Void) {
        callBack(users)
    }
    
}

class UserViewProtocolMock : NSObject, UserViewProtocol {
    var setUsersCalled = false
    var setEmptyUsersCalled = false
    
    func setUsers(users: [UserViewData]) {
        setUsersCalled = true
    }
    
    func setEmptyUsers() {
        setEmptyUsersCalled = true
    }
    
    func startLoading() {
    }
    
    func finishLoading() {
    }
    
}

class MVPTestTests: XCTestCase {
    
    let emptyUsersServiceMock = UserServiceMock(users: [User]())
    let usersServiceMock = UserServiceMock(users: [User(firstName: "firstname1", lastName: "lastname1",
                                                        email: "first@test.com", age: 30),
                                                   User(firstName: "firstname2", lastName: "lastname2",
                                                        email: "second@test.com", age: 24)])
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldSetEmptyIfNoUserAvailable() {
        // given
        let userViewProtocolMock = UserViewProtocolMock()
        let userPresenterUnderTest = UserPresenter(userService: emptyUsersServiceMock)
        userPresenterUnderTest.attachViewProtocol(viewProtocol: userViewProtocolMock)
        
        // when
        userPresenterUnderTest.getUsers()
        
        // verify
        XCTAssertTrue(userViewProtocolMock.setEmptyUsersCalled)
    }
    
    func testShouldSetUsers() {
        // given
        let userViewProtocolMock = UserViewProtocolMock()
        let userPresenterUnderTest = UserPresenter(userService: usersServiceMock)
        userPresenterUnderTest.attachViewProtocol(viewProtocol: userViewProtocolMock)
        
        // when
        userPresenterUnderTest.getUsers()
        
        // verify
        XCTAssertTrue(userViewProtocolMock.setUsersCalled)
    }
    
}
