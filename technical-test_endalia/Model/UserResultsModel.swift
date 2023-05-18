//
//  UserResultsModel.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 12/5/23.
//

import Foundation

struct UserResult: Codable {
    let id: Int
    let name, username, email: String
    let phone: String
}
