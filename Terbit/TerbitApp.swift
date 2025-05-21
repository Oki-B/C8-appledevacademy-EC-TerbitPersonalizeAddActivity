//
//  TerbitApp.swift
//  Terbit
//
//  Created by Syaoki Biek on 17/05/25.
//

import SwiftUI

@main
struct TerbitApp: App {
    var body: some Scene {
        WindowGroup {
            let routine = RoutineModel()
            ManageRoutineView(routine: routine)
        }
        .modelContainer(for: [RoutineModel.self, RoutineActivityModel.self])
    }
}
