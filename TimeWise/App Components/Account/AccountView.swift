//
//  AccountView.swift
//  TimeWise
//
//  Created by Dhriti on 04/05/2566 BE.
//

import SwiftUI

struct AccountView: View {

    @EnvironmentObject var sessionService: SessionServiceImpl
    
    var body: some View {
        
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            VStack(spacing: 0) {
                
                ImageView(size: size, safeArea: safeArea)
                    .ignoresSafeArea(.all, edges: .top)

                ContactUsView()
                
                ButtonView(title: "Logout") {
                    sessionService.logout()
                        
                }
                .padding()
                
            }
        }
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
