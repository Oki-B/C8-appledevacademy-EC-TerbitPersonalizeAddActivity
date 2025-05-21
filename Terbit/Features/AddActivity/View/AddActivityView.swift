//
//  AddActivityView.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct AddActivityView: View {
    //    @State private var searchText: String = ""
    @State private var isPresented: Bool = false
    @State private var isOnSearch: Bool = false
    @State private var showFilter = false
    @State private var navigateToResult = false
    @StateObject private var filterViewModel = FilterActivityViewModel()

    @StateObject private var viewModel = AddActivityViewModel()
    @ObservedObject var manageRoutineViewModel: ManageRoutineViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                if !isOnSearch {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Suggested Activity")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(manageRoutineViewModel.suggested(), id: \.self) { index in
                                        if index < viewModel.allActivities.count {
                                            let activity = viewModel.allActivities[index]
                                            SuggestedActivityCard(
                                                activity: activity,
                                                manageRoutineViewModel: manageRoutineViewModel
                                            )
                                        }
                                    }
                                }
                            }
                            .contentMargins(16)
                        }
                    }
                }

                ActivityList(
                    activities: viewModel.filteredActivities,
                    onSortSelected: { option in
                        viewModel.selectedSortOption = option
                        viewModel.updateSearchResults()
                    },
                    manageRoutineViewModel: manageRoutineViewModel
                )

            }
        }
        .contentMargins(.top, 12)
        .toolbarBackground(.toolbar, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle("Add Activity")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, isPresented: $isOnSearch)
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.updateSearchResults()
        }
        .onAppear {
            viewModel.loadActivities()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Filter") {
                    showFilter = true
                }
                .foregroundStyle(.secondaryBlue)
            }
        }
        .sheet(isPresented: $showFilter) {
            NavigationStack {
                FilterActivityView(
                    viewModel: filterViewModel,
                    onApply: {
                        showFilter = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            navigateToResult = true
                        }
                    }, manageRoutineViewModel: manageRoutineViewModel
                )
            }
            
        }

        // 👇 Put this here to avoid ambiguity and make result navigation work
        .navigationDestination(isPresented: $navigateToResult) {
            FilterResultView(viewModel: filterViewModel, manageRoutineViewModel: manageRoutineViewModel)
        }
    }
}

#Preview {
    let routine = RoutineModel.sampleData.first!
    let sampleVM = ManageRoutineViewModel(
        myRoutine: routine,
        context: SampleData.shared.context
    )

    NavigationStack {
        AddActivityView(manageRoutineViewModel: sampleVM)
    }
}
