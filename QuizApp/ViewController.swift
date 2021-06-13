//
//  ViewController.swift
//  QuizApp
//
//  Created by Abdul Dayur on 6/5/21.
//

// Created a custom Protocol, so that when the background thread comes back from fetching the json data
// It has a reference to the view controller. So they can notify that vc and pass the data to it for display.

import UIKit

class ViewController: UIViewController, QuizProtocol, ResultViewControllerProtocol, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numsCorrect = 0
    
    var resultDialog: ResultViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the result dialog
        resultDialog = storyboard?.instantiateViewController(identifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set up the model
        model.delegate = self
        model.getQuestions()
        
        resultDialog?.delegate = self
        
    }
    
    func displayQuestion() {
        // Check if there are questions and index is not out bounds
        guard questions.count > 0 && currentQuestionIndex < questions.count else {return}
        
        questionLabel.text = questions[currentQuestionIndex].question
        
        // Reload table.view
        tableView.reloadData()
    }
    
    
    // Kickoff getQuestions method.
    // Quizmodel starts to retrieve questions in the background.
    // When ready quizmodel calls back to vc. from vc you can get those questions ready for display
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        
        // Get reference to the questions. Passed from quizmodel
        self.questions = questions
        
        // Display the first question
        displayQuestion()
        
    }
    
    
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // make sure the answers array is not empty
        guard questions.count > 0 else {return 0}
        
        let currentQuestion = questions[currentQuestionIndex]
        
        // Return number of answers for this question
        if currentQuestion.answers != nil {
            return currentQuestion.answers!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        // Customize it
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil {
            // Set the answer text for the label
            let question = questions[currentQuestionIndex]
            
            if question.answers != nil && indexPath.row < question.answers!.count{
                label!.text = question.answers![indexPath.row]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var title = ""
        
        // check if tapped row is correct ans
        let question = questions[currentQuestionIndex]
        
        if question.correctAnswerIndex == indexPath.row{
            print("CORRECT", "User got it right")
            title = "CORRECT"
            numsCorrect += 1
        } else {
            print("WRONG", question.feedback!)
            title = "WRONG"
        }
        
        // Show the popup
        if resultDialog != nil {
            
            resultDialog!.titleText = title
            resultDialog!.feedbackText = question.feedback!
            resultDialog!.buttonText = "Next"
                
            
            
            present(resultDialog!, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - ResultProtocol Methods
    
    func dialogDismissed() {
        
        currentQuestionIndex += 1
        
        if currentQuestionIndex == questions.count {
            // The user has answered the last question
            // Show a summary Dialog
            // Show the popup
            if resultDialog != nil {
                
                resultDialog!.titleText = "Summary"
                resultDialog!.feedbackText = "You got \(numsCorrect) correct out of \(questions.count) questions"
                resultDialog!.buttonText = "Restart"
        
                present(resultDialog!, animated: true, completion: nil)
            }
            
        } else if currentQuestionIndex < questions.count {
            
            // Display next question
            displayQuestion()
        } else {
            numsCorrect = 0
            currentQuestionIndex = 0
            displayQuestion()
        }
        
    }
}

