//
//  TimeWiseApp.swift
//  TimeWise
//
//  Created by Dhriti on 29/04/2566 BE.
//

import SwiftUI
import CoreData
import Firebase

@main
struct TimeWiseApp: App {
    
    let persistenceController = PersistenceController.shared
    let notificationHandler = NotificationHandler()

    
    @StateObject var pomodoroModel: PomodoroModel = .init()
    
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    init() {
        notificationHandler.askPermission()
        notificationHandler.checkNotificationAccess()
    }

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//Initializing FireBase

class Delegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
        
    }
}
