//
//  DetailView.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 18/5/23.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: .size_x_8(multiplied: 3)) {
            AvatarView(imageData: user.photoUser, name: user.name!, size: 100)
            Text(user.name!)
                .foregroundColor(.blue)
                .font(.title)
                .fontWeight(.bold)
            HStack(spacing: .size_x_8(multiplied: 2)) {
                
                Button {
                    if let url = URL(string: "tel://" + user.phone!) {
                        UIApplication.shared.open(url)
                    }
    
                } label: {
                    Image(systemName: "phone.circle.fill")
                        .resizable()
                        .imageScale(.large)
                        .frame(width: 30, height: 30)
                }
                
                
                Button {
                    if let url = URL(string: "mailto:" + user.email!) {
                        UIApplication.shared.open(url)
                    }

                } label: {
                    Image(systemName: "envelope.circle.fill")
                        .resizable()
                        .imageScale(.large)
                        .frame(width: 30, height: 30)
                    
                }
            }
            
            
            VStack {
                Divider()
                row(title: "Puesto", info: user.workStation!)
                row(title: "Teléfono", info: user.phone!)
                row(title: "Móvil", info: user.phone!)
                row(title: "Correo electrónico", info: user.email!)
            }
            .padding(.leading)
            
            Spacer()
            
        }
        
        
    }
    private func row(title: String, info: String) -> some View {
        return VStack(alignment: .leading) {
            //title
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.gray.opacity(0.5))
            //Info
            Text(info)
            Divider()
        }
    }
    
}

