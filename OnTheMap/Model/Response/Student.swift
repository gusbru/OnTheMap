//
//  Student.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-23.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation

struct Student: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
}



/*
 
 {
     "firstName": "Bla",
     "lastName": "Blu",
     "longitude": 13.134848,
     "latitude": 47.904185,
     "mapString": "Seekirchen am Wallersee, Salzburg",
     "mediaURL": "https://google.at",
     "uniqueKey": "1234",
     "objectId": "bqh09c10s05mpe5seokg",
     "createdAt": "2020-04-23T21:12:16.116Z",
     "updatedAt": "2020-04-23T21:12:16.116Z"
 },
 
 */
