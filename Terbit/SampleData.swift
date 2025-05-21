//
//  SampleData.swift
//  Terbit
//
//  Created by Syaoki Biek on 17/05/25.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var routineActivities: RoutineModel {
        RoutineModel.sampleData.first!
    }
    
    
    private init() {
        let schema = Schema([
            RoutineModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }

    }
    
    private func insertSampleData() {
        for activity in RoutineModel.sampleData {
            context.insert(activity)
        }
        routineActivities.hasCompleteQuestionnaire = true
    }
}
