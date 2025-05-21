//
//  RoutineActivityModel.swift
//  Terbit
//
//  Created by Syaoki Biek on 17/05/25.
//

import Foundation
import SwiftData

@Model
class RoutineActivityModel {

    var activityID: Int
    var title: String
    var desc: String
    var instructions: [String]
    var duration: Int
    var logoImage: String
    var images: [String]
    var instructionDurations: [Int]
    var detailsImage: String
    var category: String
    var sortOrder: Int

    init(activity: ActivityModel, sortOrder: Int) {
        self.activityID = activity.id
        self.title = activity.title
        self.desc = activity.desc
        self.instructions = activity.instructions
        self.duration = activity.duration
        self.logoImage = activity.logoImage
        self.images = activity.images
        self.instructionDurations = activity.instructionDurations
        self.detailsImage = activity.detailsImage
        self.category = activity.category
        self.sortOrder = sortOrder
    }

    var asActivityModel: ActivityModel {
        ActivityModel(
            id: activityID,
            title: title,
            desc: desc,
            instructions: instructions,
            duration: duration,
            logoImage: logoImage,
            images: images,
            instructionDurations: instructionDurations,
            detailsImage: detailsImage,
            category: category
        )
    }
}

extension RoutineActivityModel: Hashable {
    static func == (lhs: RoutineActivityModel, rhs: RoutineActivityModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
