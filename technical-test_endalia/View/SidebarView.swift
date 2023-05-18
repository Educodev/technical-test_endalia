//
//  SwiftUIView.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 18/5/23.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    let currentUser: User
    
    var body: some View {
                
        VStack(alignment: .leading) {
            AvatarView(imageData: currentUser.photoUser, name: currentUser.name!, size: 100)
            
            Text(currentUser.name!)
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button {
                viewModel.showSidebar()
                viewModel.logOut()
            } label: {
                
                HStack(spacing: .size_x_8(multiplied: 3)) {
                    
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                        .foregroundColor(.blue)
                    
                    Text("Cerrar sesión")
                        .foregroundColor(.black)
                }
                
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width/1.4)
        .background(.white)
        .offset(x: viewModel.dinamycWidth, y: 0)
    
    }
}

