//
//  HabitView.swift
//  HabitTracker
//
//  Created by Dhriti on 03/06/2566 BE.
//

import SwiftUI
import CoreData

struct HabitView: View {
    
    @FetchRequest( entity: Habit.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \Habit.dateAdded, ascending: false)],
                   predicate: nil, animation: .easeInOut)
    var habits: FetchedResults<Habit>
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var habitModel: HabitViewModel = .init()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("Habits")
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .overlay (alignment: .trailing){
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 10)
            
            //MAKING ADD BUTTON CENTER WHEN HABITS EMPTY
            
            ScrollView(habits.isEmpty ? .init() : .vertical, showsIndicators: false) {
                VStack (spacing: 15) {
                    
                    ForEach(habits) { habit in
                        HabitCardView(habit: habit)
                    }
                    
                    //MARK: Add habit button
                    Button {
                        habitModel.addNewHabit.toggle()
                    } label: {
                        Label {
                            Text("New Habit")
                        } icon: {
                            Image(systemName: "plus.circle")
                        }
                        .font(.callout.bold())
                        .foregroundColor(.white)
                    }
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .padding(.vertical)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .sheet(isPresented: $habitModel.addNewHabit) {
            
            //MARK: Erasing all existing content
            habitModel.resetData()
            
        } content: {
            AddNewHabit()
                .environmentObject(habitModel)
        }
    }
    
    //MARK: Habit Card View
    
    @ViewBuilder
    func HabitCardView(habit: Habit) -> some View {
        
        VStack (spacing: 6) {
            HStack {
                Text(habit.title ?? "")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Image(systemName: "bell.badge.fill")
                    .font(.callout)
                    .foregroundColor(Color(habit.color ?? "Card-1"))
                    .scaleEffect(0.9)
                    .opacity(habit.isReminderOn ? 1 : 0)
                
                Spacer()
                
                let count = (habit.weekDays?.count ?? 0)
                Text(count == 7 ? "Everyday" : "\(count) times a week")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
            
            //MARK: Displaying Current Week and Marking Active days of Habit
            let calendar  = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calendar.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
            let activeWeekDays = habit.weekDays ?? []
            let activePlot = symbols.indices.compactMap { index -> (String, Date) in
                let currentDate = calendar.date(byAdding: .day, value: index, to: startDate)
                return (symbols[index], currentDate!)
            }
            
            HStack (spacing: 0) {
                
                ForEach(activePlot, id: \.0) { item in
                    let (symbol, currentDate) = item
                    
                    VStack(spacing: 6) {
                        Text(symbol.prefix(3))
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        let status = activeWeekDays.contains { day in
                            return day == symbol
                        }
                        
                        Text(getDate(date: currentDate))
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color(habit.color ?? "Card-1"))
                                    .opacity(status ? 1 : 0)
                                
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 15)
        }
        .padding(.vertical)
        .padding(.horizontal, 6)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color("TFBG").opacity(0.5))
        }
        .onTapGesture {
            //MARK: Editing Habit
            habitModel.editHabit = habit
            habitModel.restoreEditData()
            habitModel.addNewHabit.toggle()
        }
    }
    
    //MARK: Formatting Date
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitTrackerView()
    }
}
