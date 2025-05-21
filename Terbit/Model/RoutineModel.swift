//
//  RoutineModel.swift
//  Terbit
//
//  Created by Syaoki Biek on 17/05/25.
//

import Foundation
import SwiftData

@Model
class RoutineModel {
    
    var id: UUID
    @Relationship(deleteRule: .cascade)
    var selectedActivities: [RoutineActivityModel] = []
    var hasCompleteQuestionnaire: Bool
    var suggestionIndexes: [Int] = []

    init(id: UUID = .init(), selectedActivities: [RoutineActivityModel] = [], hasCompleteQuestionnaire: Bool = false, suggestionIndexes: [Int] = []) {
        self.id = id
        self.selectedActivities = selectedActivities
        self.hasCompleteQuestionnaire = hasCompleteQuestionnaire
        self.suggestionIndexes = suggestionIndexes
    }
    
    static let sampleData = [
        RoutineModel(
            selectedActivities: [
                RoutineActivityModel(
                    activity: ActivityModel(
                        id: 1,
                        title: "Desk Mobility Flow",
                        desc:
                            "This seated stretch sequence refreshes your body...",
                        instructions: ["Step 1", "Step 2"],
                        duration: 3,
                        logoImage: "figure.strengthtraining.functional",
                        images: ["image1", "image2"],
                        instructionDurations: [30, 30],
                        detailsImage: "detailsImage",
                        category: "physical"
                    ),
                    sortOrder: 1
                ),
                RoutineActivityModel(
                    activity: ActivityModel(
                        id: 2,
                        title: "Desk Mobility Flow",
                        desc:
                            "This seated stretch sequence refreshes your body...",
                        instructions: ["Step 1", "Step 2"],
                        duration: 3,
                        logoImage: "figure.strengthtraining.functional",
                        images: ["image1", "image2"],
                        instructionDurations: [30, 30],
                        detailsImage: "detailsImage",
                        category: "physical"
                    ),
                    sortOrder: 2
                ),
            ])
    ]
}

extension RoutineModel: Identifiable {}
