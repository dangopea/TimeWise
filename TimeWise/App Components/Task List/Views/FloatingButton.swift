//
//  FloatingButton.swift
//  TimeWise
//
//  Created by Dhriti on 4/22/2566 BE.
//

import SwiftUI

struct FloatingButton: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    let ButtonColor = Color("ButtonColor")
    
    var body: some View {
        
        Spacer()
        HStack {
            NavigationLink(destination: TaskEditView(passedTaskItem: nil, initalDate: Date()).environmentObject(dateHolder)) {
                
                Text("Add something! 🎉")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(animate ? Color(red: 0.5, green: 0.2, blue: 0.7) : secondaryAccentColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(
                color: animate ? Color(red: 0.5, green: 0.2, blue: 0.7).opacity(0.7) : secondaryAccentColor.opacity(0.7),
                radius: animate ? 30 : 10 ,
                x: 0.0,
                y: animate ? 50 : 30)
            .scaleEffect(animate ? 1.1 : 1.0)
            .offset(y: animate ?  -7 : 0)
        }
        .multilineTextAlignment(.center)
        .onAppear(perform: addAnimation)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
        
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}



struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
