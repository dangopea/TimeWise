//
//  InputTextFieldView.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//

import SwiftUI

struct InputTextFieldView: View {
    
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        
        TextField(placeholder, text: $text)
            .frame(maxWidth: .infinity, minHeight: 44)
            .padding(.leading, sfSymbol == nil ? textFieldLeading/2: textFieldLeading)
            .keyboardType(keyboardType)
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

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            InputTextFieldView(
                text: .constant(""),
                placeholder: "Username",
                keyboardType: .default,
                sfSymbol: "person")
            .preview(with: "Username Text Input")
            
            InputTextFieldView(
                text: .constant(""),
                placeholder: "Email",
                keyboardType: .emailAddress,
                sfSymbol: "envelope")
            .preview(with: "Email Text Input")
            
           /* InputTextFieldView(
                text: .constant(""),
                placeholder: "Email",
                keyboardType: .emailAddress,
                sfSymbol: "envelope")
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Username Text Input")
            .padding() */

        }
    }
}
