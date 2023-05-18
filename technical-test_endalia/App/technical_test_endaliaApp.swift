//
//  technical_test_endaliaApp.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 11/5/23.
//

import SwiftUI

@main
struct technical_test_endaliaApp: App {
    let persistenceController = PersistenceController.shared
    
        @ObservedObject var viewModel =  ViewModel()

        var body: some Scene {
            WindowGroup {
                if AppStorages.shared.isLogged {
                    UsersListView()
                        .environmentObject(viewModel)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else  {
                    LoginView()
                        .environmentObject(viewModel)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)   
                    
                }
            }
        }
    }
