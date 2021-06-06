//
//  QuizModel.swift
//  QuizApp
//
//  Created by Abdul Dayur on 6/6/21.
//

import Foundation


protocol QuizProtocol {
    func questionsRetrieved(_ questions:[Question])
}

class QuizModel {
    
    var delegate: QuizProtocol?
    
    func getQuestions() {
        
        // TODO: Fetch the questions
        
        
        // Notify the delegate of the retrieved questions
        delegate?.questionsRetrieved([Question]())
    }
    
    
}
