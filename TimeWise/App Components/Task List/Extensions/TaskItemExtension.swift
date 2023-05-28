//
//  TaskItemExtension.swift
//  TimeWise
//
//  Created by Dhriti on 4/22/2566 BE.
//

import SwiftUI

extension TaskItem {
    
    func isCompleted() -> Bool {
        return completedDate != nil
    }
    
    func isOverdue() -> Bool {
        
        if let due = dueDate {
            return !isCompleted() && scheduleTime && due < Date()
        }
        return false
    }
    
    func isActive() -> Bool {
        if let start = startDate, let due = dueDate {
            let currentDate = Date()
            return !isCompleted() && scheduleTime && currentDate >= start && currentDate <= due
        }
        return false
    }
    
    func overDueColor() -> Color {
        return isOverdue() ? .red : .black
    }
    
    func activeColor() -> Color {
        if let dueDate = dueDate {
            if !isCompleted() && scheduleTime && startDate ?? Date() < dueDate {
                return .green
            } else if dueDate < Date() {
                return .red
            }
        }
        return .black
    }

    
    func dueDateTimeOnly() -> String {
        
        if let due = dueDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: due)
        }
        
        return ""
    }
    
    func startDateTimeOnly() -> String {
        
        if let start = startDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: start)
        }
        
        return ""
    }
    
    func dueDateOnly() -> String {
        
        if let due = dueDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: due)
        }
        
        return ""
    }
    
    func startDateOnly() -> String {
        
        if let start = startDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: start)
        }
        
        return ""
    }
    
    func startdtOnly() -> String {
        
        if let start = startDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy 'at' hh:mm a"
            return dateFormatter.string(from: start)
        }
        
        return ""
    }
    
    func sendStartNotification() {
        
        guard let startDate = self.startDate, self.isReminder else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d,yyyy h:mm a"
        
        let title = "\(self.name ?? "") - Start Reminder"
        let body = "You have a task starting now: \(self.name ?? "")"
        
        NotificationHandler().sendNotification(
            date: startDate,
            notif_title: title,
            notif_body: body
        )
    }
    
    func sendDueNotification() {
        guard let dueDate = self.dueDate, self.isReminder else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        
        let title = "\(self.name ?? "") - Due Reminder"
        let body = "You have a task due now: \(self.name ?? "")"
        
        NotificationHandler().sendNotification(
            date: dueDate,
            notif_title: title,
            notif_body: body
        )
    }
}

