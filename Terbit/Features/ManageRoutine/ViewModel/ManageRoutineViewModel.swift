//
//  ManageRoutineViewModel.swift
//  Terbit
//
//  Created by Syaoki Biek on 17/05/25.
//

import Foundation
import Observation
import SwiftData

@MainActor
class ManageRoutineViewModel: ObservableObject {

    private var context: ModelContext
    @Published var myRoutine: RoutineModel

    init(myRoutine: RoutineModel, context: ModelContext) {
        self.myRoutine = myRoutine
        self.context = context
    }
    
    func isSuggested() {
        myRoutine.hasCompleteQuestionnaire = true
        let indexes = Array(0..<20).shuffled().prefix(10)
        myRoutine.suggestionIndexes = Array(indexes)
    }
    
    func suggested() -> [Int] {
        return myRoutine.suggestionIndexes
    }

    func add(activity: ActivityModel) {
        // Check if activity already exists in routine
        let alreadyExists = myRoutine.selectedActivities.contains {
            $0.activityID == activity.id
        }

        guard !alreadyExists else {
            print("Activity already added")
            return
        }

        // Create a new RoutineActivityModel
        let sortOrder = (myRoutine.selectedActivities.map { $0.sortOrder }.max() ?? 0) + 1
        let newRoutineActivity = RoutineActivityModel(
            activity: activity,
            sortOrder: sortOrder
        )

        // Append to the routine's activities
        myRoutine.selectedActivities.append(newRoutineActivity)

        // Persist the change
        context.insert(newRoutineActivity)

        do {
            try context.save()
            print("Activity added successfully.")
        } catch {
            print("Failed to save activity: \(error)")
        }
    }

    func removeActivity(at index: Int) {
        guard index < myRoutine.selectedActivities.count else {
            return
        }

        let activity = myRoutine.selectedActivities[index]

        myRoutine.selectedActivities.removeAll { $0 == activity }

        context.delete(activity)

        try? context.save()
    }

    func containsActivity(_ activity: ActivityModel) -> Bool {
        return myRoutine.selectedActivities.contains(where: {
            $0.activityID == activity.id
        })
    }

}
