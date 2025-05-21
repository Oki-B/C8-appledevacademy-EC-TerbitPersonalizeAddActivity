//
//  CategoryFilterSection.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct CategoryFilterSection: View {
    @ObservedObject var viewModel: FilterActivityViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Category")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 6)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 12
            ) {
                ForEach(viewModel.allCategories, id: \.self) { category in
                    Button(action: {
                        viewModel.toggleCategory(category)
                    }) {
                        Text(
                            (viewModel.selectedCategories.contains(category)
                                ? "✓  " : "") + "\(category == "ScreenTime" ? "Screen Time" : category)"
                        )
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
//                            Color.blue
                            viewModel.selectedCategories.contains(category)
                            ? .secondaryBlue : .containerBG
                        )
                        .foregroundStyle(
                            viewModel.selectedCategories.contains(category)
                                ? .white : .black
//                            .white
                        )
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
}

//#Preview {
//    CategoryFilterSection(viewModel: FilterActivityViewModel())
//}
