//
//  SuggestedActivityCard.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct SuggestedActivityCard: View {
    let activity: ActivityModel
    @ObservedObject var manageRoutineViewModel: ManageRoutineViewModel
    
    var body: some View {
        // Suggested Activity Card
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                Image("\(activity.detailsImage)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: UIScreen.main.bounds
                            .width * 0.9,
                            height: 240
                    )

                VStack(alignment: .trailing) {
                    Text("\(activity.category)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(
                            .init(
                                top: 12,
                                leading: 0,
                                bottom: 0,
                                trailing: 16
                            )
                        ).shadow(color: .black.opacity(0.8), radius: 3,)

                    Spacer()

                    HStack(alignment: .center) {
                        VStack (alignment: .leading){
                            Text("\(activity.title)")
                            HStack {
                                Image(
                                    systemName:
                                        "clock"
                                )
                                Text("5 mins")
                            }
                            .foregroundStyle(
                                .secondary
                            )
                            .font(.callout)
                        }
                        Spacer()
                        Button("Add") {
                            manageRoutineViewModel.add(activity: activity)
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 8)
                        .background(Color(manageRoutineViewModel.containsActivity(activity) ? .gray : .secondaryBlue ))
                        .cornerRadius(25)
                        .foregroundStyle(.white)
                        .disabled(manageRoutineViewModel.containsActivity(activity))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                }
            }
            .cornerRadius(12)
            .shadow(radius: 4)
        }
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
        detailsImage: "DetailsDeskMobility",
        category: "physical"
    )
    let sampleVM = ManageRoutineViewModel(myRoutine: routine, context: SampleData.shared.context)
    
    SuggestedActivityCard(activity: sampleData, manageRoutineViewModel: sampleVM)
}
