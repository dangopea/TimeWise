//
//  ButtonView.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//
import SwiftUI

struct ButtonView: View {
    
    typealias ActionHandler = () -> Void
    
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    
    let AccentColor = Color("AccentColor")
    
    private let cornerRadius: CGFloat = 10
    
    internal init(
        title: String,
        background: Color = Color("AccentColor"),
        foreground: Color = .white,
        border: Color = .clear,
        handler: @escaping ButtonView.ActionHandler)
    {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler, label: {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        })
        .background(background)
        .foregroundColor(foreground)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(border, lineWidth: 2)
        )
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        ButtonView(title: "Primary Button") { }
            .preview(with: "Primary Button View")
        
        ButtonView(
            title: "Secondary Button",
            background: .clear,
            foreground: Color("AccentColor"),
            border: Color("AccentColor")) { }
            .preview(with: "Secondary Button View")
        
    }
}
 
