//
//  RoutineActivityRow.swift
//  Terbit
//
//  Created by Syaoki Biek on 17/05/25.
//

import SwiftUI

struct RoutineActivityRow: View {
    @State var activity: RoutineActivityModel
    
    var body: some View {
        HStack(spacing: 10) {
            Image(activity.logoImage)
                .resizable()
                .cornerRadius(10)
                .frame(width: 45, height: 45)
                .foregroundStyle(.orange)
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.title)
                HStack {
                    Image(systemName: "clock")
                    Text("\(activity.duration) mins")
                }
                .foregroundStyle(.secondary)
                .font(.callout)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundStyle(.gray)

            }
            
            Rectangle()
                .frame(width: 8, height: 70)
                .foregroundStyle(.secondaryBlue)
        }
    }
}

