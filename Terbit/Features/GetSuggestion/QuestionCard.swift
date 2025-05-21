//
//  QuestionCardView.swift
//  Terbit
//
//  Created by Syaoki Biek on 19/05/25.
//

import SwiftUI

enum Option {
    case a
    case b
    case c
    case d
}

struct QuestionCardView: View {
    
    let questionIndex: Int  // 0-based index
    let totalQuestions: Int
    var question: QuestionnaireQuestion
    var selectedCategory: String?
    var onSelect: (String) -> Void

    @State private var selectedOption: Option?

    var body: some View {

        VStack {
            HStack(spacing: 2) {
                ForEach(0..<totalQuestions, id: \.self) { i in
                    Rectangle()
                        .fill(i < questionIndex ? Color.secondaryBlue : Color.containerBG)
                        .frame(width: .infinity, height: 6)
                        .cornerRadius(4)
                }
            }.padding(.vertical, 20)

            VStack {
                Group {
                    HStack {
                        Spacer()
                        Text("\(questionIndex)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondaryBlue)
                    }
                    .padding()

                    Text(question.question
                    )
                    .font(.system(size: 16, weight: .medium))
                    .padding(.bottom, 24)

                    VStack(spacing: 16) {
                        ForEach(
                            Array(question.answers.enumerated()),
                            id: \.element.id
                        ) { index, answer in
                            let option: Option = {
                                switch index {
                                case 0: return .a
                                case 1: return .b
                                case 2: return .c
                                case 3: return .d
                                default: return .a
                                }
                            }()

                            RadioButton(
                                tag: option,
                                selection: $selectedOption,
                                label: answer.text
                            )
                            .onChange(of: selectedOption) { oldValue, newValue in
                                if let newValue = newValue {
                                    let index = indexForOption(newValue)
                                    onSelect(question.answers[index].category)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom)

                }
                .padding(.horizontal, 20)
                Spacer()

                Rectangle()
                    .fill(.secondaryBlue)
                    .frame(height: 12)
            }

            .background(.containerBG)
            .cornerRadius(16)

        }
        .frame(width: .infinity, height: 450)
    }

    private func indexForOption(_ option: Option) -> Int {
        switch option {
        case .a: return 0
        case .b: return 1
        case .c: return 2
        case .d: return 3
        }
    }
}

//#Preview {
//    QuestionCardView()
//}
