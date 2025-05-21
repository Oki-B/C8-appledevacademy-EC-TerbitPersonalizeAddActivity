//
//  FilterResultView.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct FilterResultView: View {
    @State private var isPresented: Bool = false
    @State private var isOnSearch: Bool = false

    @StateObject var viewModel: FilterActivityViewModel
    @ObservedObject var manageRoutineViewModel: ManageRoutineViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ActivityList(
                    activities: viewModel.sortedActivities,
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
        .navigationTitle("Result (\(viewModel.resultCount))")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, isPresented: $isOnSearch)
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.updateSearchResults()
        }
        .onAppear {
            viewModel.loadActivities()
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
        FilterResultView(viewModel: FilterActivityViewModel(), manageRoutineViewModel: sampleVM)
    }
}
