//
//  SuggestionModel.swift
//  Terbit
//
//  Created by Syaoki Biek on 19/05/25.
//

import Foundation

struct QuestionnaireQuestion: Codable, Identifiable {
    let id = UUID()
    let question: String
    let answers: [AnswerOption]
}

struct AnswerOption: Codable, Identifiable {
    let id = UUID()
    let text: String
    let category: String
}
