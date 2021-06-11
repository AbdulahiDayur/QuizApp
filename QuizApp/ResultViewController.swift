//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Abdul Dayur on 6/9/21.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var dimView: UIView!
    @IBOutlet var dailogView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var feedBackLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Now that the elements have loaded, set the text
        titleLabel.text = titleText
        feedBackLabel.text = feedbackText
        nextButton.setTitle(buttonText, for: .normal)
    }
    @IBAction func dismissTapped(_ sender: Any) {
        
    }
    
    

}
