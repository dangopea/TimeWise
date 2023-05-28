//
//  SpashScreenView.swift
//  TimeWise
//
//  Created by Dhriti on 4/13/2566 BE.
//

import SwiftUI
import CoreData

struct SplashScreenView: View {
    
    let persistenceController = PersistenceController.shared
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    
    var body: some View {
        
        if isActive {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        } else {
            
            VStack {
                VStack {
                    Text("🍡")
                        .font(.system(size: 80))
                    
                    Text("TimeWise")
                        .font(Font.custom("Baskerville", size: 26))
                        .foregroundColor(.black.opacity(0.80))
                    Text("by dangodot")
                        .font(Font.custom("Baskerville", size: 15))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                        
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
