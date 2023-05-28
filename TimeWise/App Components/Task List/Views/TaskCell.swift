//
//  TaskCell.swift
//  TimeWise
//
//  Created by Dhriti on 4/22/2566 BE.
//

import SwiftUI

struct TaskCell: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    let notify = NotificationHandler()
    
    var body: some View {
        
        let somestr = passedTaskItem.dueDateOnly() + " at " + passedTaskItem.dueDateTimeOnly()
        let somestr1 = passedTaskItem.startDateOnly() + " " + passedTaskItem.startDateTimeOnly() + " - " + passedTaskItem.dueDateTimeOnly()
        let somestr2 = passedTaskItem.startDateOnly() + " - " + passedTaskItem.dueDateOnly()
        let somestr3 = passedTaskItem.startDateOnly() + " " + passedTaskItem.startDateTimeOnly() + " - " + passedTaskItem.dueDateOnly() + " " + passedTaskItem.dueDateTimeOnly()
        
        CheckBoxView(passedTaskItem: passedTaskItem)
            .environmentObject(dateHolder)
        Text(passedTaskItem.name ?? "")
            .padding(.horizontal)
        
        if (!passedTaskItem.isCompleted() && passedTaskItem.scheduleTime) { // This is if the task isn't completed and schedule time is turned on
            
            if (passedTaskItem.startDateOnly() == passedTaskItem.dueDateOnly() && passedTaskItem.startDateTimeOnly() == passedTaskItem.dueDateTimeOnly()) {
                //If the start date & time are the same thing as the due date & time
                
                Text(somestr)
                    .font(.footnote)
                    .foregroundColor(passedTaskItem.isOverdue() ? passedTaskItem.overDueColor() : passedTaskItem.activeColor())
                    .padding(.horizontal)
                    .multilineTextAlignment(.trailing)
                
                if passedTaskItem.isReminder { // If reminder is on
                    let _ = passedTaskItem.sendStartNotification()
                }
                
            } else {
                if (passedTaskItem.startDateOnly() == passedTaskItem.dueDateOnly()) { //If only the start date end due date are the same, but the time is different
                    Spacer()
                    
                    Text(somestr1)
                        .font(.footnote)
                        .foregroundColor(passedTaskItem.isOverdue() ? passedTaskItem.overDueColor() : passedTaskItem.activeColor())
                        .padding(.horizontal)
                        .multilineTextAlignment(.trailing)
                    
                    if passedTaskItem.isReminder { // If reminder is on
                        let _ = passedTaskItem.sendStartNotification()
                        let _ = passedTaskItem.sendDueNotification()
                    }
                }
                
                if (passedTaskItem.startDateOnly() != passedTaskItem.dueDateOnly() && passedTaskItem.startDateTimeOnly() != passedTaskItem.dueDateTimeOnly()) {
                    
                    Text(somestr3)
                        .font(.footnote)
                        .foregroundColor(passedTaskItem.isOverdue() ? passedTaskItem.overDueColor() : passedTaskItem.activeColor())
                        .padding(.horizontal)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        
        else if !passedTaskItem.isCompleted() && !passedTaskItem.scheduleTime { // This is if the task isn't completed, and schedule time is turned off
            
            if passedTaskItem.startDateOnly() == passedTaskItem.dueDateOnly() { // If the start and due date are the same thing
                Text(passedTaskItem.dueDateOnly())
                    .font(.footnote)
                    .foregroundColor(passedTaskItem.isOverdue() ? passedTaskItem.overDueColor() : passedTaskItem.activeColor())
                    .padding(.horizontal)
                    .multilineTextAlignment(.trailing)
                
                if passedTaskItem.isReminder { // If reminder is on
                    let _ = passedTaskItem.sendStartNotification()
                }
                
            } else { // If the start date and due date are different
                Spacer()
                Text(somestr2)
                    .font(.footnote)
                
                if passedTaskItem.isReminder { // If reminder is on
                    let _ = passedTaskItem.sendStartNotification()
                    let _ = passedTaskItem.sendDueNotification()
                }
                
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(passedTaskItem: TaskItem())
    }
}
