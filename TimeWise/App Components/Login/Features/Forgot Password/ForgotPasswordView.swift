//
//  ForgotPasswordView.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var vm = ForgotPasswordViewModelImpl(service: ForgotPasswordServiceImpl())
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 16) {
                
                InputTextFieldView(
                    text: $vm.email,
                    placeholder: "Enter your email address",
                    keyboardType: .emailAddress,
                    sfSymbol: "envelope")
                
                ButtonView(title: "Send Password Reset") {
                    vm.sendPasswordReset()
                    
                }
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 15)
            .navigationTitle("Reset Password")
            .applyClose()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
