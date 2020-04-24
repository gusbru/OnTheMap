//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-23.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation

struct Udacity: Codable {
    var username: String
    var password: String
}

struct LoginRequest: Codable {
    var udacity: Udacity
}

/*
 
 {
     "udacity": {
         "username": "email",
         "password": "password"
         
     }
 }
 
 */
