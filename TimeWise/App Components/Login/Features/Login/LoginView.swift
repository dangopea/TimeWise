//
//  LoginView.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//

import SwiftUI

struct LoginView: View {
    
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    
    @StateObject private var vm = LoginViewModelImpl(service: LoginServiceImpl())
    
    let AccentColor = Color("AccentColor")

    var body: some View {
        
        VStack(spacing: 16) {
            
            Image("logo")
                .resizable()
                .padding()
            
            VStack(spacing: 16) {
                
                InputTextFieldView(
                    text: $vm.credentials.email,
                    placeholder: "Enter email-id here....",
                    keyboardType: .emailAddress,
                    sfSymbol: "envelope")
                
                InputPasswordView(
                    password: $vm.credentials.password,
                    placeholder: "Enter password here...",
                    sfSymbol: "lock")
            }
            
            
            
            VStack(spacing: 16) {
                
                ButtonView(title: "Login") {
                    vm.login()
                }
                
                ButtonView(
                    title: "Register account",
                    background: .clear,
                    foreground: Color("AccentColor"),
                    border: Color("AccentColor")) {
                        showRegistration.toggle()
                    }
                    .sheet(isPresented: $showRegistration) {
                        RegisterView()
                    }
            }
            
            HStack {
                
                Button(action: {
                    showForgotPassword.toggle()
                }, label: {
                    Text("Forgot password?")
                })
                .font(.system(size: 16, weight: .bold))
                .sheet(isPresented: $showForgotPassword) {
                    ForgotPasswordView()
                }
            }
            
        }
        .padding(.horizontal, 15)
        .navigationTitle("Login Page")
        .alert(isPresented: $vm.hasError, content:  {
            
            if case .failed(let error) = vm.state {
                return Alert(title: Text("Error"), message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Error"), message: Text("Something went wrong"))
            }
            
            })
        .background()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
