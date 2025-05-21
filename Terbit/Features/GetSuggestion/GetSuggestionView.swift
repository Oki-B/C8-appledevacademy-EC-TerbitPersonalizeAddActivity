//
//  GetSuggestionView.swift
//  Terbit
//
//  Created by Syaoki Biek on 18/05/25.
//

import SwiftUI

struct GetSuggestionView: View {
    @State var manageRoutineViewModel: ManageRoutineViewModel
    @StateObject private var viewModel = GetSuggestionViewModel()
    @State private var selectedOption: Option?

    var body: some View {
        HStack (alignment: .top){
            VStack {
                if let question = viewModel.currentQuestion {
                    QuestionCardView(
                        questionIndex: viewModel.currentStep,
                        totalQuestions: viewModel.questions.count,
                        question: question,
                        selectedCategory: viewModel.selectedAnswers[question.id],
                        onSelect: { category in
                            viewModel.selectAnswer(for: question.id, category: category)
                        }
                    )
                } else {
                    VStack {
                        Spacer()
                        Text("Let's find your focus style")
                            .font(.title)
                            .fontWeight(.semibold)

                        Image(systemName: "person.crop.circle.dashed.circle")
                            .font(Font.system(size: 120))
                            .fontWeight(.light)
                            .foregroundStyle(Color.secondaryBlue.opacity(0.8))
                            .padding(.vertical, 10)

                        Text(
                            "Answer 5 quick questions to discover activities that help you focus."
                        )
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .padding(.bottom, 60)
                    }.frame(height: 450)
                }

                Button {
                    if viewModel.isLastStep {
                        manageRoutineViewModel.isSuggested()
                        let suggestion = viewModel.calculateSuggestionType()
                        print("Suggested focus style: \(suggestion)")
                        
                        // Persist result to SwiftData or navigate accordingly
                    } else {
                        viewModel.currentStep += 1
                    }
                } label: {
                    Text(viewModel.currentStep == 0 ? "Start" : viewModel.isLastStep ? "Finish" : "Next")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.primaryOrange)
                        .foregroundColor(.primary)
                        .cornerRadius(36)
                        .padding(.vertical)
                }

                
                Spacer()
            }
            .padding(.top, 20)
            
        }
        .toolbarBackground(.toolbar, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle("Get Suggestion")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 30)
    }
}

#Preview {
    NavigationStack {
        GetSuggestionView(manageRoutineViewModel: ManageRoutineViewModel(myRoutine: RoutineModel(), context: SampleData.shared.context))
    }
}
