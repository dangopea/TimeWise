//
//  DateHolder.swift
//  TimeWise
//
//  Created by Dhriti on 4/22/2566 BE.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject {
    
    init(_ context: NSManagedObjectContext) {
        
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
