//
//  ViewController.swift
//  QuizApp
//
//  Created by Abdul Dayur on 6/5/21.
//

import UIKit

class ViewController: UIViewController, QuizProtocol {
    
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        model.getQuestions()
        
    }
    
    // Kickoff getQuestions method.
    // Quizmodel starts to retrieve questions in the background.
    // When ready quizmodel calls back to vc. from vc you can get those questions ready for display
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        print("questions retrieved from model!")
    }
    
}

