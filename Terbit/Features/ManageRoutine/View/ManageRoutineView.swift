//
//  ManageRoutineView.swift
//  Terbit
//
//  Created by Syaoki Biek on 17/05/25.
//

import SwiftData
import SwiftUI

struct ManageRoutineView: View {
    @Environment(\.modelContext) private var context
    @StateObject var viewModel: ManageRoutineViewModel

    init(routine: RoutineModel) {
        _viewModel = StateObject(wrappedValue: ManageRoutineViewModel( myRoutine: routine, context: ModelContext(try! ModelContainer(for: RoutineModel.self, RoutineActivityModel.self))))
    }

    var body: some View {
            NavigationStack {
            Group {
                if !viewModel.myRoutine.selectedActivities.isEmpty {
                    RoutineActivityList(viewModel: viewModel)
//                        .contentMargins(.top, 20)
                } else {
                    ContentUnavailableView {
                        Image(systemName: "rectangle.stack.fill.badge.plus")
                            .symbolRenderingMode(.palette)
                            .font(.system(size: 60))
                            .foregroundStyle(.orange.opacity(0.75))
                        Text("Your Routine")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("You can add any activity to your Routine")
                            .font(.caption)
                    }
                }
            }
            .toolbarBackground(.toolbar, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Manage Routine")

            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                        .foregroundStyle(.secondaryBlue)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        "Add",
                        destination: {
                            if viewModel.myRoutine.hasCompleteQuestionnaire {
                                AddActivityView(manageRoutineViewModel: viewModel)
                            } else {
                                GetSuggestionView(manageRoutineViewModel: viewModel)
                            }
                            
                        }
                    ).foregroundStyle(.secondaryBlue)
                }
            }

        }
    }
    

}

#Preview {
    let sampleData = SampleData.shared
    ManageRoutineView(routine: sampleData.routineActivities)
}

#Preview("Empty") {
    ManageRoutineView(routine: RoutineModel())
}


