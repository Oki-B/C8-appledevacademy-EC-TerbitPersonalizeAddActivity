//
//  RoutineActivityList.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct RoutineActivityList: View {
    @Environment(\.modelContext) private var context
    @StateObject var viewModel: ManageRoutineViewModel

    var body: some View {
        List {
            ForEach(viewModel.myRoutine.selectedActivities, id: \.id) {
                activity in
                RoutineActivityRow(activity: activity)
                    .listRowInsets(
                        EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
                    )
                    .listRowBackground(Color.containerBG)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    viewModel.removeActivity(at: index)
                }
            }
        }
        
        .contentMargins(.top, 20)
//        .padding(.vertical)

    }
}
