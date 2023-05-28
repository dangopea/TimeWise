//
//  CheckBoxView.swift
//  TimeWise
//
//  Created by Dhriti on 4/22/2566 BE.
//

import SwiftUI

struct CheckBoxView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View {
        
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill": "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green : priorityColor)
            .onTapGesture {
                withAnimation {
                    if passedTaskItem.isCompleted() {
                        // toggle off
                        passedTaskItem.completedDate = nil
                    } else {
                        // toggle on
                        passedTaskItem.completedDate = Date()
                    }
                    dateHolder.saveContext(viewContext)
                }
            }
    }
    
    private var priorityColor: Color {
        switch passedTaskItem.priority {
        case "High":
            return .red
        case "Medium":
            return .yellow
        case "Low":
            return .blue
        default:
            return .yellow
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(passedTaskItem: TaskItem())
    }
}
