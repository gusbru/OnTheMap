//
//  PostLocationRequest.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-24.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation

struct PostLocationRequest: Codable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
}

/*
 
{
    "uniqueKey": "some-key",
    "firstName": "John",
    "lastName": "Doe",
    "mapString": "Mountain View, CA",
    "mediaURL": "https://udacity.com",
    "latitude": 37.386052,
    "longitude": -122.083851
}
 
 */
