//
//  InputSecureView.swift
//  technical-test_endalia
//
//  Created by Eduardo Herrera on 11/5/23.
//

import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.none)
                } else {
                    TextField(title, text: $text)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.none)
                }
            }.padding(.trailing, .size_x_8(multiplied: 4))

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}
