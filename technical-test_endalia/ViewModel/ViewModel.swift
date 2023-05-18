
//
//  ViewModel.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 12/5/23.
//

import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var workstationSelected = Workstation.agent
    @Published var name = ""
    @Published var userTextSignin = ""
    @Published var passwordTextSignin = ""
    @Published var phoneRegister = ""
    @Published var userTextRegister = ""
    @Published var passwordTextRegister = ""
    @Published var checkPassword = ""
    @Published var showMessage = false
    @Published var isAuth = false
    @Published var searchText = ""
    @Published var opendSideBar = false
    @Published var dinamycWidth: CGFloat = -UIScreen.main.bounds.width/1.4
    
    
    
    
    //var  users = Model().users
    
    func getUsersFromServices(_ context: NSManagedObjectContext) async {
        let usersResult: [UserResult]? = await generateUsers(apiUrl: .jptypecode)
        
        if let  usersResult = usersResult {
            for user in usersResult {
                let newUser = User(context: context)
                newUser.id = UUID()
                newUser.name = user.name
                newUser.phone = user.phone
                newUser.email = user.email
                newUser.password  = "passwordDefault"
                newUser.workStation = Workstation.agent.rawValue
                
            }
            
            //here randomly generate users ninety-nine times from another service.
            for _ in 0...90 {
                if let users: RandomUser = await generateUsers(apiUrl: .randomuser) {
                    let user = users.results[0]
                    let newUser = User(context: context)
                    newUser.id = UUID()
                    newUser.photoUser = await getImage(urlString: user.picture.medium)
                    newUser.name = user.name.first + " " + user.name.last
                    newUser.phone = user.phone
                    newUser.email = user.email
                    newUser.password  = user.login.password
                    newUser.workStation = Workstation.environmentalAuditor.rawValue
                }
            }
            
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func createUser(_ context: NSManagedObjectContext) {
        if isValidateEmail().isEmpty && isValidatePass().isEmpty && verifyPasswordIfEqual().isEmpty && isValidateInputName().isEmpty {
            isAuth.toggle()
            let newUser = User(context: context)
            newUser.id = UUID()
            newUser.phone = phoneRegister
            newUser.name = name
            newUser.email = userTextRegister
            newUser.password = passwordTextRegister
            newUser.workStation = workstationSelected.rawValue
            AppStorages.shared.isLogged = true
            AppStorages.shared.userID = newUser.id!.uuidString
            
            do {
                try context.save()
                
                isAuth.toggle()
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            showMessage.toggle()
        }
    }
    
    func logIn(users: FetchedResults<User>) {
        
        if users.contains(where: {$0.email == userTextSignin && $0.password == passwordTextSignin}) {
            let userLogged = users.map({$0}).filter({($0.email == userTextSignin) && ($0.password == passwordTextSignin)})
            AppStorages.shared.userID = userLogged[0].id!.uuidString
            AppStorages.shared.isLogged = true
            isAuth = true
        } else {
            showMessage.toggle()
        }
    }
    
    func logOut() {
        AppStorages.shared.isLogged = false
        AppStorages.shared.userID = ""
    }
    
    func isValidateEmail() -> String {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailPred.evaluate(with: userTextRegister) ? "El formato no corresponde al de un correo " : ""
    }
    
    func isValidatePass() -> String {
        let punctuation = "¡!@#$%^&*(),.<>;'`~[]{}\\|/?_-+="
        let passRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?!.* ).{8,16}"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        var containsCharSpecial = false
        
        for char in passwordTextRegister {
            containsCharSpecial =  punctuation.contains(char)
        }
        return passPred.evaluate(with: passwordTextRegister) && containsCharSpecial ? "" : "La contraseña debe de contener minimo 8 caracteres, almenos una letra mayuscula, una minuscula, un numero y un caracter especial"
    }
    
    func verifyPasswordIfEqual() -> String {
        return checkPassword != passwordTextRegister ? "Las contraseñas no coinciden" : ""
    }
    
    func isValidateInputPhone() -> String {
        return phoneRegister.isEmpty ? "Este campo no puede estar vacío" : ""
    }
    
    func isValidateInputName() -> String {
        return name.isEmpty ? "Este campo no puede estar vacío" : ""
    }
    
    func showSidebar() {
        withAnimation {
            if !(dinamycWidth == 0) {
                dinamycWidth = 0
            } else {
                dinamycWidth = -UIScreen.main.bounds.width/1.4
            }
            
        }
    }
    
    private func getImage(urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else {return nil}
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}


