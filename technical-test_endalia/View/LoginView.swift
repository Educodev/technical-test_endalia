//
//  LoginView.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 11/5/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.email, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            VStack(spacing: .size_x_8(multiplied: 2)) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/2, height: 40)
                    .padding(.bottom, .size_x_8(multiplied:4))
                
                //Email
                VStack(spacing: .size_x_8(multiplied: 2))  {
                    HStack(spacing: .size_x_8(multiplied: 2))  {
                        Image(systemName: "person")
                            .imageScale(.large)
                            
                            .foregroundColor(.blue)
                        TextField("Usuario", text: $viewModel.userTextSignin)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.none)
                            
                    }
                    
                    Divider()
                }
                // Password
                VStack(spacing: .size_x_8(multiplied: 2))  {
                    HStack(spacing: .size_x_8(multiplied: 2))  {
                        Image(systemName: "lock")
                            .imageScale(.large)
                            
                            .foregroundColor(.blue)
                        SecureInputView("Contraseña", text: $viewModel.passwordTextSignin)
                            

                    }
                    
                    Divider()
                }
                
               
            
                
                
                //access button
                Button {
                    viewModel.logIn(users: users)
                } label: {
                    Text("Acceder")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: .size_x_8(multiplied: 1)).stroke())
                        .foregroundColor(.gray)
                }
                
                //register button
                NavigationLink {
                  RegisterView()
                } label: {
                    Text("Registrarme")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(.size_x_8(multiplied: 1))
                        
                }
                
                

                
            }
            .padding(.horizontal, .size_x_8(multiplied: 4))
        }
        .task {
            if users.isEmpty {
                await viewModel.getUsersFromServices(context)
            }
        }
        .alert("¡Algo salio mal!", isPresented: $viewModel.showMessage) {
            Button("Ok") {
                viewModel.showMessage.toggle()
            }
        } message: {
            Text("El correo o la contraseña son incorrectos")
        }
    }
}

