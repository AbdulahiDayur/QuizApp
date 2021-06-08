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
        
        // Fetch the questions
        getLocalJsonFile()
        
    }
    
    func getLocalJsonFile() {
        
        // Get bundle path to json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // Double check that the path isn't nil
        guard path != nil else {
            print("Couldn't find the json data file")
            return
        }
        
        // Create URL object from the path
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            
            // Try to decode the data into objects
           let array = try decoder.decode([Question].self, from: data)
            
            // Notify the delegate of the parsed objects
            delegate?.questionsRetrieved(array)
        } catch {
            // Error: Couldn't download the data at that URL
        }
    }
    
    func getRemoteJsonFile() {
        
    }
    
    
}
