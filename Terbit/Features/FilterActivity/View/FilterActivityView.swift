//
//  FilterActivityView.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct FilterActivityView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: FilterActivityViewModel
    var onApply: () -> Void
    @Environment(\.modelContext) private var context
    @StateObject var manageRoutineViewModel: ManageRoutineViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            CategoryFilterSection(viewModel: viewModel)
            DurationFilterSection(viewModel: viewModel)
            
            Button("Show Result (\(viewModel.resultCount))") {
                // Apply filter logic or dismiss and pass data
                dismiss()
                onApply()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            .font(.headline)
            .background(.primaryOrange)
            .cornerRadius(46)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Filter")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Reset") {
                    viewModel.resetFilters()
                }
            }
        }
        .onAppear {
            viewModel.resetFilters()
        }
    }
}


//#Preview {
//    NavigationStack {
//        FilterActivityView(manageRoutineViewModel: ManageRoutineViewModel(myRoutine: RoutineModel(), context: SampleData.shared.context))
//    }
//}
