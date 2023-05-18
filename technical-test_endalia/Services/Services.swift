//
//  Servises.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 12/5/23.
//

import Foundation

enum ApiUrls: String {
    case jptypecode = "https://jsonplaceholder.typicode.com/users"
    case randomuser = "https://randomuser.me/api/"
}

func generateUsers<T:Codable>(apiUrl: ApiUrls) async -> T? {
    guard let url = URL(string: apiUrl.rawValue) else {return nil}
    
    do {
        let (jsonData, response) = try await URLSession.shared.data(from: url)
        let httpUrlResponse = response as? HTTPURLResponse
        
        if httpUrlResponse?.statusCode == 200 {
            let userResults = try JSONDecoder().decode(T.self, from: jsonData)
            return userResults
        }
    } catch let error {
        print(error.localizedDescription)
    }
    return nil
}
