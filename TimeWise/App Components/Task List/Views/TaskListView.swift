//
//  TaskListView.swift
//  TimeWise
//
//  Created by Dhriti on 4/22/2566 BE.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    
    //Environment objects
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    // Fetch request
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<TaskItem>
    
    var body: some View {
        NavigationView { Color(red: 0.5, green: 0.7, blue: 0.3).ignoresSafeArea().overlay(
            VStack {
                Divider()
                if items.isEmpty {
                    VStack(alignment: .center, spacing: 8) {
                        Text("There are no items!")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("To be successful, one must have a system. \nCome on, feed me your task list!\nMake a plan based on it!")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 50)
                    
                }
                else {
                    List {
                        ForEach(items) { taskItem in
                            NavigationLink(
                                destination: TaskEditView(
                                    passedTaskItem: taskItem,
                                    initalDate: Date())
                                .environmentObject(dateHolder))
                            {
                                TaskCell(passedTaskItem: taskItem)
                                    .environmentObject(dateHolder)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                    
                }
                FloatingButton()
                    .environmentObject(dateHolder)
            }
                .navigationTitle("Task List 📋")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        EditButton()
                    }
                }
        )}
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            dateHolder.saveContext(viewContext)
        }
    }
    
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
