//
//  ActivityRow.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct ActivityRow: View {
    let activity: ActivityModel
    @ObservedObject var manageRoutineViewModel: ManageRoutineViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Rectangle()
                .frame(width: 10, height: 80)
                .foregroundStyle(.secondaryBlue)

            Image("\(activity.logoImage)")
                .resizable()
                .cornerRadius(10)
                .frame(width: 50, height: 50)
                .foregroundStyle(.orange)
                .aspectRatio(contentMode: .fit)

            VStack(alignment: .leading) {
                Text("\(activity.title)")
                    .lineLimit(1)
                    .font(.system(size: 16))

                HStack {
                    Image(systemName: "clock")
                    Text("\(activity.duration) mins")
                }
                .foregroundStyle(.secondary)
                .font(.callout)
            }
            Spacer()

            Button {
//                onAdd(activity)
                manageRoutineViewModel.add(activity: activity)
            } label: {
                Text("Add")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(Color(manageRoutineViewModel.containsActivity(activity) ? .gray : .secondaryBlue))
                    .background(Color.blue)
                    .cornerRadius(25)
                    .foregroundStyle(.white)
            }
            .disabled(manageRoutineViewModel.containsActivity(activity))
        }
        .padding(.trailing)
        .cornerRadius(10)
    }
}


#Preview {
    let routine = RoutineModel.sampleData.first!
    let sampleData : ActivityModel = .init (
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
    )
    let sampleVM = ManageRoutineViewModel(myRoutine: routine, context: SampleData.shared.context)
    
    ActivityRow(activity: sampleData, manageRoutineViewModel: sampleVM)
}
