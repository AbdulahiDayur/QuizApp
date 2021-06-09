//
//  Question.swift
//  QuizApp
//
//  Created by Abdul Dayur on 6/5/21.
//

import Foundation

struct Question: Codable {
    
    var question: String?
    var answers: [String]?
    var correctAnswerIndex: Int?
    var feedback: String?
    
    
}
