//
//  ContactUsView.swift
//  TimeWise
//
//  Created by Dhriti on 05/05/2566 BE.
//

import SwiftUI

struct ContactUsView: View {
    @State private var isShowingMailView = false
    
    var body: some View {
        VStack {
            Button(action: {
                isShowingMailView = true
                sendMail()
            }) {
                Text("Contact Us")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowingMailView: $isShowingMailView)
        }
    }
    
    private func sendMail() {
        let email = "mailto:dangoteam.assist@gmail.com"
        guard let url = URL(string: email) else { return }
        UIApplication.shared.open(url)
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

struct MailView: View {
    @Binding var isShowingMailView: Bool
    
    var body: some View {
        EmptyView()
            .onAppear {
                isShowingMailView = false
            }
    }
}
