//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by Gustavo Brunetto on 2020-04-24.
//  Copyright © 2020 Gustavo Brunetto. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    var status: Int
    var error: String
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
