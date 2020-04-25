//
//  LogoutResponse.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-24.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation

struct LogoutResponse: Codable {
    var session: Session
}


/*

{
     "session": {
        "id": "1463940997_7b474542a32efb8096ab58ced0b748fe",
        "expiration": "2015-07-22T18:16:37.881210Z"
     }
}
 
 */
