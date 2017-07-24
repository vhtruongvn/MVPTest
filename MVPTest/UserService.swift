//
//  UserService.swift
//  MVPTest
//
//  Created by Truong Vo on 7/24/17.
//  Copyright © 2017 Truong Vo. All rights reserved.
//

import Foundation

class UserService {
    
    // the service delivers mocked data with a delay
    func getUsers(callBack:@escaping ([User]) -> Void){
        let users = [User(firstName: "Iyad", lastName: "Agha", email: "iyad@test.com", age: 36),
                     User(firstName: "Mila", lastName: "Haward", email: "mila@test.com", age: 24),
                     User(firstName: "Mark", lastName: "Astun", email: "mark@test.com", age: 39)
        ]
        
        // 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            callBack(users)
        }
    }
    
}
