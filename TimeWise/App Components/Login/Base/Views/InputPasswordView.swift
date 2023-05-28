//
//  InputPasswordView.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//


import SwiftUI

struct InputPasswordView: View {
    
    @Binding var password: String
    let placeholder: String
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    var body: some View {
        
        SecureField(placeholder, text: $password)
            .frame(maxWidth: .infinity, maxHeight: 44)
            .padding(.leading, sfSymbol == nil ? textFieldLeading/2 : textFieldLeading)
            .background(
            
                ZStack(alignment: .leading, content: {
                    if let systemImage = sfSymbol {
                        Image(systemName: systemImage)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading, 5)
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.gray.opacity(0.25))

                })
            )
    }
}

struct InputPasswordView_Previews : PreviewProvider {
    static var previews: some View {
        
        InputPasswordView(
            password: .constant(""),
            placeholder: "Password",
            sfSymbol: "lock")
        .preview(with: "Input Password View w/ Symbol")
        
        InputPasswordView(
            password: .constant(""),
            placeholder: "Password",
            sfSymbol: nil)
        .preview(with: "Input Password View w/o Symbol")
    }
}

