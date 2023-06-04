//
//  HomeView.swift
//  TimeWise
//
//  Created by Dhriti on 4/13/2566 BE.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    @EnvironmentObject var pomodoroModel: PomodoroModel
    @Environment(\.presentationMode) var presentationMode
    
    let persistenceController = PersistenceController.shared

    var body: some View {
        NavigationView {
            Color(red: 0.5, green: 0.7, blue: 0.3)
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        Text("Welcome to TimeWise, \(sessionService.userDetails?.username ?? "your personal growth app.")")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()

                        NavigationLink(destination: PomoView()) {
                            Text("Open Pomodoro Timer")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("Green"))
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                            
                        }
                        
                        NavigationLink(
                            destination: HabitTrackerView()
                                .environment(\.managedObjectContext,
                                              persistenceController.container.viewContext)
                        ) {
                            Text("Open Habit Tracker")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("Green"))
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                            
                        }
                        
                        NavigationLink(
                            destination: NotesView()
                                .environment(\.managedObjectContext,
                                              persistenceController.container.viewContext)
                        ) {
                            Text("Open Notes")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("Green"))
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                            
                        }
                        
                        Spacer()
                    }
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionServiceImpl())
            .environmentObject(PomodoroModel())
    }
}

