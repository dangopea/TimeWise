//
//  PomodoroModel.swift
//  TimeWise
//
//  Created by Dhriti on 28/05/2566 BE.
//

import SwiftUI
import UserNotifications

class PomodoroModel: NSObject, ObservableObject {
    //MARK: Timer Properties
    
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String  = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    @Published var isFinished: Bool = false
    
    override init() {
        super.init()
    }
    
    func startTimer() {
        withAnimation(.easeInOut(duration: 0.25)) { isStarted = true }
        timerStringValue =
        "\(hour == 0 ? "" : "\(hour) :")\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        
        totalSeconds = (hour * 3600) + (minutes * 60) + (seconds)
        staticTotalSeconds = totalSeconds
        addNewTimer = false
    }
    
    func stopTimer() {
        withAnimation {
            isStarted = false
            hour = 0
            minutes = 0
            seconds = 0
            progress = 1
            timerStringValue = "00:00"
        }
    }
    
    func updateTimer() {
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        hour = (totalSeconds / 3600)
        minutes = (totalSeconds / 60) % 60
        seconds = (totalSeconds % 60)
        timerStringValue =
        "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        
        if hour  == 0 && seconds == 0 && minutes == 0 {
            isStarted = false
            print("Ended timer.")
            isFinished = true
            addNotification()
        }
    }
    
    func addNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { [weak self] granted, error in
            if let error = error {
                // Handle error
                print("Error requesting notification authorization: \(error.localizedDescription)")
            } else if granted {
                let content = UNMutableNotificationContent()
                content.title = "TimeWise"
                content.subtitle = "Time's up! Your timer has finished."
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self?.staticTotalSeconds ?? 0), repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                center.add(request) { error in
                    if let error = error {
                        // Handle error
                        print("Error adding notification request: \(error.localizedDescription)")
                    } else {
                        // Notification request added successfully
                    }
                }
            }
        }
    }
}


