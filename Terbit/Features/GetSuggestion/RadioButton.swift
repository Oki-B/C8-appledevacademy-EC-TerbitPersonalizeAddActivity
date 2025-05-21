//
//  RadioButton.swift
//  Terbit
//
//  Created by Syaoki Biek on 11/05/25.
//

import SwiftUI

struct RadioButton: View {
    @Binding private var isSelected: Bool
    private let label: String
    
    init(isSelected: Binding<Bool>, label: String = "") {
        self._isSelected = isSelected
        self.label = label
    }
    
    // To support multiple options
     init<V: Hashable>(tag: V, selection: Binding<V?>, label: String = "") {
       self._isSelected = Binding(
         get: { selection.wrappedValue == tag },
         set: { _ in selection.wrappedValue = tag }
       )
       self.label = label
     }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            circleView
            labelView
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.isSelected.toggle()
        }
        
    }
}

private extension RadioButton {
    @ViewBuilder var labelView: some View {
        Text("\(label)")
            .font(.system(size: 15))
    }
    
    @ViewBuilder var circleView: some View {
        Circle()
            .fill(innerCircleColor)
            .padding(4)
            .overlay(
                Circle()
                    .stroke(outlineColor, lineWidth: 1)
            )
            .frame(width: 20, height: 20)
    }
}

private extension RadioButton {
    var innerCircleColor: Color {
        return isSelected ? Color.blue : Color.clear
    }
    
    var outlineColor: Color {
        return isSelected ? Color.blue : Color.gray
    }
}

//#Preview {
//    RadioButton()
//}
