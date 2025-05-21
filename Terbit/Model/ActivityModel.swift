//
//  ActivityModel.swift
//  Terbit
//
//  Created by Syaoki Biek on 17/05/25.
//

import Foundation
//import SwiftData

//@Model
struct ActivityModel: Identifiable, Codable, Hashable {
    var id: Int
    var title: String
    var desc: String
    var instructions: [String]
    var duration: Int
    var logoImage: String
    var images: [String]
    var instructionDurations: [Int]
    var detailsImage: String
    var category: String

    init(
        id: Int,
        title: String,
        desc: String,
        instructions: [String],
        duration: Int,
        logoImage: String,
        images: [String],
        instructionDurations: [Int],
        detailsImage: String,
        category: String,
    ) {
        self.id = id
        self.title = title
        self.desc = desc
        self.instructions = instructions
        self.duration = duration
        self.logoImage = logoImage
        self.images = images
        self.instructionDurations = instructionDurations
        self.detailsImage = detailsImage
        self.category = category
    }
    
}
