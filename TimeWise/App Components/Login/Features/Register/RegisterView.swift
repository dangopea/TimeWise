//
//  RegisterView.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var vm = RegistrationViewModelImpl(service: RegistrationServiceImpl())
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    
                    InputTextFieldView(text: $vm.userDetails.username,
                                       placeholder: "Enter username here....",
                                       keyboardType: .default,
                                       sfSymbol: "person")
                    
                    InputTextFieldView(text: $vm.userDetails.email,
                                       placeholder: "Enter email address here....",
                                       keyboardType: .emailAddress,
                                       sfSymbol: "envelope")
                    
                    InputPasswordView(password: $vm.userDetails.password,
                                      placeholder: "Enter password here....",
                                      sfSymbol: "lock")
                    
                    Divider()
                }
                
                ButtonView(title: "Sign up!") {
                    vm.register()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Register account")
            .alert(isPresented: $vm.hasError, content:  {
                
                if case .failed(let error) = vm.state {
                    return Alert(title: Text("Error"), message: Text(error.localizedDescription))
                } else {
                    return Alert(title: Text("Error"), message: Text("Something went wrong"))
                }
                
                })
            .applyClose()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
