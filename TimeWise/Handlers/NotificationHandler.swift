//
//  NotificationHandler.swift
//  TimeWise
//
//  Created by Dhriti on 29/04/2566 BE.
//

import Foundation
import UserNotifications

class NotificationHandler {
    
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in

            if success {
                print("Access Granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(date: Date, notif_title: String, notif_body: String) {
        
        var trigger: UNNotificationTrigger?
        
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = notif_title
        content.body = notif_body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
}
