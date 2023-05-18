//
//  UsersList.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 12/5/23.
//

import SwiftUI

struct UsersListView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.email, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>
    private var  alphabet = Array("abcdefghijklmnopqrstuvwxyz").map({String($0).uppercased()})

    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            let currentUser = users.filter({$0.id! == UUID(uuidString: AppStorages.shared.userID)}).first ?? users.first
            
            NavigationView  {
                ScrollViewReader {proxy in
                    ScrollView(showsIndicators: false) {
                        
                        
                            
                            //Container for all
                            VStack(alignment: .leading) {
                                //Loop
                                ForEach(Array(alphabet.enumerated()), id: \.offset) {index,char in
                                    
                                    let users_ = users.map({$0})
                                    
                                    let filteredUsers =  users_.filter({$0.name!.prefix(1) == char})
                                    
                                    let searcheUsers = filteredUsers.filter({$0.name!.contains(viewModel.searchText) || $0.workStation!.contains(viewModel.searchText)})
                                    
                                    if index == 0 {
                                        //Tittle
                                        Text("Tú")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(.blue)
                                            .padding(.top, .size_x_8(multiplied: 3))
                                            .padding(.horizontal)
                                        
                                        row(currentUser)
                                        
                                        //Tittle
                                        Text("Todos")
                                            .fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(.blue)
                                            .padding(.bottom, .size_x_8(multiplied: 4))
                                            .padding(.horizontal)
                                    }
                                    
                                    //Section for each char
                                    Section {
                                        ForEach(viewModel.searchText.isEmpty ? filteredUsers : searcheUsers) { user in
                                            row(user)
                                        }
                                        
                                    } header: {
                                        VStack(alignment: .leading) {
                                            Text(char)
                                                .padding(.horizontal)
                                            Color.gray
                                                .frame(width: UIScreen.main.bounds.width, height: 1)
                                        }
                                        .id(char)
                                    }
                                    
                                    
                                }
                            }
                            .onChange(of: viewModel.searchText, perform: { value in
                                withAnimation {
                                    proxy.scrollTo(value, anchor: .top )
                                    
                                }
                            })
                            .listStyle(.plain)
                            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Buscar")
                            .navigationTitle("Derectorio")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement:.navigationBarLeading) {
                                    AvatarView(imageData: currentUser.photoUser, name: currentUser.name!, size: 40)
                                        .onTapGesture {
                                            viewModel.showSidebar()
                                        }
                                }
                            }
                            
                            
                        
                    }
                    .overlay(
                        VStack {
                            ForEach(alphabet, id: \.self) { char in
                                Text(char)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .onTapGesture {
                                        withAnimation {
                                            proxy.scrollTo(char, anchor: .top)
                                        }
                                    }
                            }
                        }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(4)
                        
                    )
                }
                
            }
               
            if viewModel.dinamycWidth == 0 {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showSidebar()
                    }
                
            }

            
            SidebarView(currentUser: currentUser)
            
        }
        
        
    }
    
    func row(_ user: User) -> some View {
       return NavigationLink {
            DetailView(user: user)
        } label: {
            HStack(spacing: .size_x_8(multiplied: 2)) {
                
                AvatarView(imageData: user.photoUser, name: user.name!)
                
                VStack(alignment: .leading) {
                    Text(user.name!)
                        .foregroundColor(.black)
                    Text(user.workStation!)
                        .fontWeight(.light)
                        .foregroundColor(.gray.opacity(0.4))
                }
            }
            .listRowSeparator(.hidden)
            
            .padding(.size_x_8(multiplied: 1))
            
        }
    }
}




