//
//  RegisterView.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 11/5/23.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
       
            VStack(spacing: .size_x_8(multiplied: 2))  {
                
                Spacer()
                //Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/2, height: 40)
                    .padding(.bottom, .size_x_8(multiplied:3))
                
                HStack {
                    Text("puesto de trabajo")
                        .foregroundColor(.secondary)
                    Spacer()
                    Picker("", selection: $viewModel.workstationSelected) {
                        ForEach(Workstation.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                //Phone
                VStack(spacing: .size_x_8(multiplied: 2))  {
                    VStack(alignment: .leading) {
                        HStack(spacing: .size_x_8(multiplied: 2))  {
                            Image(systemName: "phone")
                                .imageScale(.large)
                                
                                .foregroundColor(.blue)
                            TextField("Telefono", text: $viewModel.phoneRegister)
                                .keyboardType(.numberPad)
                                
                                
                        }
                        //warning name
                        warningView(viewModel.isValidateInputPhone())
                    }
                    
                    Divider()
                }
                
                //Name
                VStack(spacing: .size_x_8(multiplied: 2))  {
                    VStack(alignment: .leading) {
                        HStack(spacing: .size_x_8(multiplied: 2))  {
                            Image(systemName: "person")
                                .imageScale(.large)
                                
                                .foregroundColor(.blue)
                            TextField("Nombre Apellido", text: $viewModel.name)
                                .textInputAutocapitalization(.words)
                            
                        }
                        //warning name
                        warningView(viewModel.isValidateInputName())
                    }
                    
                    Divider()
                }
                
                
                //Email
                VStack(spacing: .size_x_8(multiplied: 2))  {
                        VStack(alignment: .leading) {
                            HStack(spacing: .size_x_8(multiplied: 2))  {
                                Image(systemName: "envelope")
                                    .imageScale(.medium)
                                    
                                    .foregroundColor(.blue)
                            TextField("Correo electronico", text: $viewModel.userTextRegister)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        }
                            //warning email
                           warningView(viewModel.isValidateEmail())
                    }
                    
                    Divider()
                }  
                
                // Password
                VStack(spacing: .size_x_8(multiplied: 2))  {
                    VStack(alignment: .leading){
                        HStack(spacing: .size_x_8(multiplied: 2))  {
                        Image(systemName: "lock")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                        SecureInputView("Contraseña", text:  $viewModel.passwordTextRegister)
                        
                    }
                        //warning password
                        warningView(viewModel.isValidatePass())
                        
                    }
                    
                    Divider()
                }
                
                // check password
                VStack(spacing: .size_x_8(multiplied: 2))  {
                    VStack(alignment: .leading){
                    HStack(spacing: .size_x_8(multiplied: 2))  {
                        Image(systemName: "lock")
                            .imageScale(.large)
                            
                            .foregroundColor(.blue)
                        SecureInputView("Vuelve a introducir contraseña", text: $viewModel.checkPassword)
                        
                    }
                    //Warning verify pass
                    warningView(viewModel.verifyPasswordIfEqual())
                }
                    
                    Divider()
                }

                            
                //Create account button
                Button {
                    viewModel.createUser(context)
                    
                } label: {
                    Text("Crear Cuenta")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(.size_x_8(multiplied: 1))
                        
                }
                
                Spacer()

                
            }
            .padding(.horizontal, .size_x_8(multiplied: 4))
            .alert("¡Algo esta mal!", isPresented: $viewModel.showMessage) {
                Button("Ok") {
                    viewModel.showMessage.toggle()
                }
            } message: {
                Text("Debe corregir los campos con errores para poder continuar")
            }

        }
    
    func warningView(_ message: String) -> some View {
        return  Text(message)
            .fontWeight(.light)
            .font(.system(size: .size_x_8(multiplied: 1)))
            .foregroundColor(.red)
    }
    }

