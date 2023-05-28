//
//  PomoView.swift
//  TimeWise
//
//  Created by Dhriti on 28/05/2566 BE.
//

import SwiftUI

struct PomoView: View {
    
    @EnvironmentObject var pomodoroModel: PomodoroModel
    
    var body: some View {
        PomodoroTimerView()
            .environmentObject(pomodoroModel)
        
    }
}

struct PomoView_Previews: PreviewProvider {
    static var previews: some View {
        PomoView()
    }
}

