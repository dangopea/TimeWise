//
//  TimeWiseApp.swift
//  TimeWise
//
//  Created by Dhriti on 21/05/2566 BE.
//

import SwiftUI

@main
struct TimeWiseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
