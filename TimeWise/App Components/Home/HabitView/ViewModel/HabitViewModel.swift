//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Dhriti on 03/06/2566 BE.
//

import SwiftUI
import CoreData
import UserNotifications

class HabitViewModel: ObservableObject {
    
    //MARK: New Habit Properties
    @Published var addNewHabit: Bool = false
    @Published var title: String = ""
    @Published var habitColor: String = "Card-1"
    @Published var weekDays: [String] = []
    @Published var isReminderOn: Bool = false
    @Published var reminderText: String = ""
    @Published var reminderDate: Date = Date()
    
    //MARK: Reminder Time Picker
    @Published var showTimePicker: Bool = false
    
    //MARK: Editing Habit
    @Published var editHabit: Habit?
    
    //MARK: Adding New Habit to Database
    func addHabit(context: NSManagedObjectContext) async -> Bool {
        
        //MARK: Editing data
        var habit: Habit!
        if let editHabit = editHabit {
            
            habit = editHabit
            
            //Removing all pending notifications
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: (editHabit.notificationIDs ?? [] as NSObject) as! [String])
            
        } else {
            habit = Habit(context: context)

        }
        
        habit.title = title
        habit.color = habitColor
        habit.weekDays = weekDays as NSObject
        habit.isReminderOn = isReminderOn
        habit.reminderText = reminderText
        habit.notificationDate = reminderDate
        habit.notificationIDs = [] as NSObject
        
        if isReminderOn {
            //MARK: Schedule Notifications
            if let ids = try? await scheduleNotifications() {
                habit.notificationIDs = ids as NSObject
                
                if let _ = try? context.save() {
                    return true
                }
                
            }
            
        } else {
            //MARK: Adding Data
            if let _ = try? context.save() {
                return true
            }
        }
        
        return false
    }
    
    
    //MARK: Notification Access Status
        @Published var notificationAccess: Bool = false
    
    init() {
            checkNotificationAccess()
        }
        
    func checkNotificationAccess() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationAccess = settings.authorizationStatus == .authorized
            }
        }
    }
    
    //MARK: Adding Notifications
    func scheduleNotifications()async throws-> [String] {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.body = reminderText
        content.sound = UNNotificationSound.default
        
        //MARK: Scheduling ids
        var notificationIDs: [String] = []
        let calendar = Calendar.current
        let weekdaySymbols: [String] = calendar.weekdaySymbols
        
        for weekDay in weekDays {
            
            //Unique id for each notification
            let id = UUID().uuidString
            
            let hour = calendar.component(.hour, from: reminderDate)
            let min = calendar.component(.minute, from: reminderDate)
            let day = weekdaySymbols.firstIndex { currentDay in
                return currentDay == weekDay
            } ?? -1
        
            if day != -1 {
                
                var components = DateComponents()
                components.hour = hour
                components.minute = min
                components.weekday = day + 1
                
                //MARK: This will trigger notif on each selected day
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                try await UNUserNotificationCenter.current().add(request)
                
                notificationIDs.append(id)
            }
        }
        
        return notificationIDs
    }
    
    //MARK: Erasing Content
    func resetData() {
         title = ""
        habitColor = "Card-1"
        weekDays = []
        isReminderOn = false
        reminderDate = Date()
        reminderText = ""
        editHabit = nil
    }
    
    //MARK: Deleting Habit from Database
    func deleteHabit(context: NSManagedObjectContext) -> Bool {
        if let editHabit = editHabit {
            if editHabit.isReminderOn {
                if editHabit.isReminderOn {
                    //Removing ALL pending notifications
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: (editHabit.notificationIDs ?? [] as NSObject) as! [String])
                }
            }
            context.delete(editHabit)
            
            if let _ = try? context.save() {
                return true
            }
        }
        return false
    }
    
    //MARK: Restoring Edit Data
    func restoreEditData() {
        
        if let editHabit = editHabit {
            title = editHabit.title ?? ""
            habitColor = editHabit.color ?? "Card-1"
            weekDays = editHabit.weekDays as? [String] ?? []
           isReminderOn = editHabit.isReminderOn
            reminderDate = editHabit.notificationDate ?? Date()
            reminderText = editHabit.reminderText ?? ""
        }
    }
    
    //MARK: Done Button Status
    func doneStatus() -> Bool {
        
        let reminderStatus = isReminderOn ? reminderText == "" : false
        
        if title == "" || weekDays.isEmpty || reminderStatus {
            return false
        }
        return true
    }
}
