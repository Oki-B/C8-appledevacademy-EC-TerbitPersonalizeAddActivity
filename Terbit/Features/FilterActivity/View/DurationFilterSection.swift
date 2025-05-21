//
//  DurationFilterSection.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

import SwiftUI

struct DurationFilterSection: View {
    @ObservedObject var viewModel: FilterActivityViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Duration")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)
                

            HStack(spacing: 12) {
                ForEach(DurationFilter.allCases) { duration in
                    let isSelected = viewModel.selectedDuration == duration

                    Button {
                        viewModel.toggleDuration(duration)
                    } label: {
                        HStack {
                            Image(systemName: "clock")
                            Text(duration.rawValue)
                        }
                        .font(.system(size: 14))
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(isSelected ? .secondaryBlue : .containerBG)
                        .foregroundColor(isSelected ? .white : .primary)
                        .cornerRadius(30)
                    }
                }
            }
            .padding(.top, 6)
        }
        .padding(.bottom, 30)
    }
}


//#Preview {
//    DurationFilterSection()
//}
