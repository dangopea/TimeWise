//
//  HabitTrackerView.swift
//  HabitTracker
//
//  Created by Dhriti on 03/06/2566 BE.
//

import SwiftUI
import CoreData

struct HabitTrackerView: View {
    var body: some View {
        HabitView()
            .preferredColorScheme(.dark)
    }
}

struct HabitTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        HabitTrackerView()
    }
}
