//
//  ContentView.swift
//  TimeWise
//
//  Created by Dhriti on 4/15/2566 BE.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let persistenceController = PersistenceController.shared
    @StateObject var sessionService = SessionServiceImpl()

    var body: some View {
        let context = persistenceController.container.viewContext
        let dateHolder = DateHolder(context)

        
            switch sessionService.state {
            case .loggedIn:
                NavigationView {
                    TabView {
                        
                        HomeView()
                            .environmentObject(sessionService)
                            .environmentObject(PomodoroModel())
                            .tabItem {
                                Image(systemName: "house.fill")
                                Text("Home")
                            }
                        
                        ProgressView()
                            .tabItem{
                                Image(systemName: "map")
                                Text("Progress")
                            }
                        
                        TaskListView()
                            .environment(\.managedObjectContext, context)
                            .environmentObject(dateHolder)
                            .tabItem{
                                Image(systemName: "list.clipboard")
                                Text("Task List")
                            }
                        
                        AccountView()
                            .environmentObject(sessionService)
                            .tabItem{
                                Image(systemName: "person.circle")
                                Text("Account")
                            }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) { }
                    }
                }
                
            case .loggedOut:
                NavigationView {
                    LoginView()
                }
            }
          
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

