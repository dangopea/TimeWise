//
//  TaskEditView.swift
//  TimeWise
//
//  Created by Dhriti on 4/22/2566 BE.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    let ButtonColor = Color("ButtonColor")
    
    // Properties
    @State var selectedTaskItem: TaskItem?
    @State var name: String
    @State var desc: String
    @State var priority: String
    @State var scheduleTime: Bool
    @State var startDate: Date
    @State var dueDate: Date
    @State var isReminder: Bool
    
    // Error messages
    @State var isShowingAlert = false
    @State var alertMessage = ""
    
    
    init(passedTaskItem: TaskItem?, initalDate: Date) {
        if let taskItem = passedTaskItem {
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _priority = State(initialValue: taskItem.priority ?? "")
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
            _startDate = State(initialValue: taskItem.startDate ?? initalDate)
            _dueDate = State(initialValue: taskItem.dueDate ?? initalDate)
            _isReminder = State(initialValue: taskItem.isReminder)
            
            // If the start date has been set, set the due date to the same time
            if let start = taskItem.startDate, taskItem.scheduleTime {
                let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: start)
                _dueDate.wrappedValue = Calendar.current.date(from: components)!
            } }
        else {
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _priority = State(initialValue: "")
            _scheduleTime = State(initialValue: false)
            _startDate = State(initialValue: initalDate)
            _dueDate = State(initialValue: initalDate)
            _isReminder = State(initialValue: false)
        }
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.5, green: 0.7, blue: 0.3).ignoresSafeArea()
                NavigationView {
                    Form{
                        Section(header: Text("Task Details")) {
                            TextField("Task Name", text: $name)
                            TextField("Task Description", text: $desc)
                        }
                        
                        Section(header: Text("Priority").multilineTextAlignment(.center)) {
                            
                            Picker("PriorityPicker", selection: $priority) {
                                Text("High").tag("High")
                                Text("Medium").tag("Medium")
                                Text("Low").tag("Low")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(getBackgroundColor())
                            .cornerRadius(10)
                        }
                        
                        Section(header: Text("Date & Time")) {
                            if scheduleTime {
                                DatePicker(
                                    "Start Date",
                                    selection: $startDate,
                                    displayedComponents: displayComps())
                                .onChange(of: startDate) { value in
                                    // If start date changes, update due date to match
                                    let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: value)
                                    dueDate = Calendar.current.date(from: components)!
                                }
                                DatePicker("Due Date", selection: $dueDate, displayedComponents: displayComps())
                            } else {
                                
                                // If scheduleTime is off, show date picker without time
                                DatePicker("Start Date",
                                           selection: $startDate,
                                           displayedComponents: displayComps())
                                
                                DatePicker("Due Date",
                                           selection: $dueDate,
                                           in: startDate...,
                                           displayedComponents: displayComps())
                            }
                            
                            Toggle("Schedule Time", isOn: $scheduleTime)
                            
                            Toggle("Remind me: ", isOn: $isReminder)
                            
                        }
                        
                        
                        if selectedTaskItem?.isCompleted() ?? false {
                            
                            Section(header: Text("Completed")) {
                                Text(selectedTaskItem?.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                                    .foregroundColor(.green)
                            }
                        }
                        
                        Section() {
                            Button("Save", action: saveAction)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                
                    .navigationTitle("Add/Edit Task")

        }
    }
    
    
    func displayComps() -> DatePickerComponents {
        
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    func saveAction() {
        withAnimation {
            if selectedTaskItem == nil {
                selectedTaskItem = TaskItem(context: viewContext)
            }
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                
                showAlert(
                    title: "Invalid name" ,
                    message: "Please fill out the task name. You can't leave it empty!"
                )

                return
                
            }
            else if name.count < 3 {
                
                showAlert(
                    title: "Invalid Name",
                    message: "The task name must be at least 3 characters long."
                )

                return
            }
            
            selectedTaskItem?.name = name
            selectedTaskItem?.desc = desc
            selectedTaskItem?.priority = priority
            selectedTaskItem?.scheduleTime = scheduleTime
            selectedTaskItem?.startDate = startDate
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.isReminder = isReminder
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else {
            fatalError("Failed to find window scene and window.")
        }
        
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func getBackgroundColor() -> Color {
        switch priority {
        case "High":
            return Color.red
        case "Medium":
            return Color.yellow
        case "Low":
            return Color.blue
        default:
            return Color.clear
        }
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(passedTaskItem: TaskItem(), initalDate: Date())
    }
}
