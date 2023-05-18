//
//  RandomUser.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 17/5/23.
//

import Foundation

// MARK: - RandomUser
struct RandomUser: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: Name
    let email: String
    let login: Login
    let phone: String
    let picture: Picture
}

// MARK: - Login
struct Login: Codable {
    let password: String
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let medium: String
}

