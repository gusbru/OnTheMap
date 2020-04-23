//
//  StudentInformationRequest.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-23.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation


struct StudentInformationResponse: Codable {
    var studentsList: [Student]
    
    enum CodingKeys: String, CodingKey {
        case studentsList = "results"
    }
}
