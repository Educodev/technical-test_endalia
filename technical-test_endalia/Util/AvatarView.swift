//
//  AvatarView.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 18/5/23.
//

import SwiftUI

struct AvatarView: View {
    let imageData: Data?
    let name: String
    var size: CGFloat = 55
    
    var body: some View {
        if let photoUserData = imageData {
            Image(uiImage: UIImage(data: photoUserData)!)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: size)
        } else {
            Text(name.prefix(1))
                .fontWeight(.bold)
                .font(.system(size: size - 25))
                .frame(width: size, height: size)
                .background(.gray.opacity(0.5))
                .clipShape(Circle())
                
        }

    }
}
