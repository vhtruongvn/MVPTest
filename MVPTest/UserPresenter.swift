//
//  UserPresenter.swift
//  MVPTest
//
//  Created by Truong Vo on 7/24/17.
//  Copyright © 2017 Truong Vo. All rights reserved.
//

import Foundation

// proper format of data for displaying
struct UserViewData {
    let name: String
    let age: String
}

/* 
 Protocols declare the methods expected to be used for a particular situation.
 Protocols are also useful in situations where the class of an object isn’t known, or needs to stay hidden.
 By default, all methods declared in a protocol are required methods. This means that any class that conforms to the protocol must implement those methods.
 It’s also possible to specify optional methods in a protocol. These are methods that a class can implement only if it needs to.
 */
protocol UserViewProtocol: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setUsers(users: [UserViewData])
    func setEmptyUsers()
}

class UserPresenter {
    private let userService: UserService
    weak private var userViewProtocol: UserViewProtocol?
    
    init (userService: UserService) {
        self.userService = userService
    }
    
    func attachViewProtocol(viewProtocol: UserViewProtocol) {
        userViewProtocol = viewProtocol
    }
    
    func detachViewProtocol() {
        userViewProtocol = nil
    }
    
    func getUsers() {
        self.userViewProtocol?.startLoading()
        userService.getUsers{ [weak self] users in
            self?.userViewProtocol?.finishLoading()
            if (users.count == 0) {
                self?.userViewProtocol?.setEmptyUsers()
            } else {
                let mappedUsers = users.map {
                    return UserViewData(name: "\($0.firstName) \($0.lastName)", age: "\($0.age) years")
                }
                self?.userViewProtocol?.setUsers(users: mappedUsers)
            }
            
        }
    }
}
