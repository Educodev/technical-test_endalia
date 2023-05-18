//
//  AppStorages.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 12/5/23.
//

import SwiftUI

struct AppStorages {
    static let shared = AppStorages()
    
    @AppStorage("isLogged") var isLogged = false
    @AppStorage("idCurrentUser") var userID = ""
    
}
