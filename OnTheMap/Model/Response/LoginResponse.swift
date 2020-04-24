//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-23.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation

struct Account: Codable {
    var registered: Bool
    var key: String
}

struct Session: Codable {
    var id: String
    var expiration: String
}

struct LoginResponse: Codable {
    var account: Account
    var session: Session
}

/*
 

 {
     "account": {
        "registered": true,
        "key": "78443710"
     },
     "session": {
        "id": "2945693486Sc350b40cb70ed3a7fbf5dabb10cda747",
        "expiration": "2020-04-25T18:15:19.409444Z"
     }
 }
 
 */
