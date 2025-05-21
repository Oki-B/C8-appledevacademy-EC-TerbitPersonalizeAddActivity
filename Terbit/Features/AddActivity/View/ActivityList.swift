//
//  ActivityList.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct ActivityList: View {

    let activities: [ActivityModel]
    let onSortSelected: (SortOption) -> Void
    @ObservedObject var manageRoutineViewModel: ManageRoutineViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("All Activity")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()

                Menu {
                    ForEach(SortOption.allCases) { option in
                        Button(option.label) {
                            onSortSelected(option)
                        }
                    }
                } label: {
                    Text("Sort")
                    Image(systemName: "slider.vertical.3")
                }

            }
            .cornerRadius(10)

            Group {
                if activities.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "magnifyingglass")
                            .font(Font.system(size: 42))
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                        Text("No Activities")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Can't found activity match with your search")
                            .font(.caption)
                    }
                } else {
                    ForEach(activities, id: \.id) { activity in
                        ActivityRow(
                            activity: activity,
                            manageRoutineViewModel: manageRoutineViewModel
                        )
                    }
                    .padding(.trailing)
                    .background(Color.containerBG)
                    .cornerRadius(10)
                }
            }

        }
        .padding(.horizontal)

    }
}

#Preview {
    let viewModel = AddActivityViewModel()
    let routine = RoutineModel.sampleData.first!
    let manageRoutineVM = ManageRoutineViewModel(
        myRoutine: routine,
        context: SampleData.shared.context
    )

    ActivityList(
        activities: viewModel.allActivities,
        onSortSelected: { option in
            viewModel.selectedSortOption = option
            viewModel.updateSearchResults()
        },
        manageRoutineViewModel: manageRoutineVM
    )
}
