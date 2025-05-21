//
//  GetSuggestionViewModel.swift
//  Terbit
//
//  Created by Syaoki Biek on 19/05/25.
//

import Foundation

@MainActor
class GetSuggestionViewModel: ObservableObject {
    @Published var questions: [QuestionnaireQuestion] = []
    @Published var selectedAnswers: [UUID: String] = [:]  // Question ID -> Category
    @Published var currentStep: Int = 0

    init() {
        loadQuestions()
    }
    
    var currentQuestion: QuestionnaireQuestion? {
        guard currentStep > 0, currentStep <= questions.count else { return nil }
        return questions[currentStep - 1]
    }

    var isLastStep: Bool {
        currentStep == questions.count
    }
    
    func loadQuestions() {
        guard let url = Bundle.main.url(forResource: "questionnaire", withExtension: "json") else {
            print("Questionnaire JSON not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([QuestionnaireQuestion].self, from: data)
            self.questions = decoded
        } catch {
            print("Failed to decode questionnaire: \(error)")
        }
    }

    func selectAnswer(for questionID: UUID, category: String) {
        selectedAnswers[questionID] = category
    }
    
    func calculateSuggestionType() -> String {
            let counts = selectedAnswers.values.reduce(into: [String: Int]()) { result, category in
                result[category, default: 0] += 1
            }

            return counts.max(by: { $0.value < $1.value })?.key ?? "Physical"
        }
}

enum SuggestionCategory: String {
    case physical = "Physical"
    case mindfulness = "Mindfulness"
    case social = "Social"
    case screentime = "Screentime"
    
    var suggestionType: Int {
        switch self {
        case .physical: return 1
        case .mindfulness: return 2
        case .social: return 3
        case .screentime: return 4
        }
    }
}
