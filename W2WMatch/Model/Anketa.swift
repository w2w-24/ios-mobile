//
//  Anketa.swift
//  W2WMatch
//
//  Created by Floron on 20.06.2024.
//

import Foundation

// MARK: - AnketaElement
struct AnketaElement: Codable {
    var id: Int
    var text: String
    var answerType: AnswerType
    var choices: [Choice]

    enum CodingKeys: String, CodingKey {
        case id, text
        case answerType = "answer_type"
        case choices
    }
}

enum AnswerType: String, Codable {
    case image = "IMAGE"
    case many = "MANY"
    case one = "ONE"
    case text = "TEXT"
}

// MARK: - Choice
struct Choice: Codable {
    var id: Int
    var text: String
}
