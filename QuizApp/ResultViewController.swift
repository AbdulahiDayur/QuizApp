//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Abdul Dayur on 6/9/21.
//

import UIKit

protocol ResultViewControllerProtocol {
    func dialogDismissed()
}

class ResultViewController: UIViewController {
    @IBOutlet var dimView: UIView!
    
    @IBOutlet var dialogView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var feedbackLabel: UILabel!
    
    @IBOutlet var dimissButton: UIButton!
    
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    var delegate: ResultViewControllerProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Now that the elements have loaded, set the text
        titleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dimissButton.setTitle(buttonText, for: .normal)
    }

    @IBAction func dismissTapped(_ sender: Any) {
        // Dismiss the popup
        dismiss(animated: true, completion: nil)
        
        // Notify delegate the popup was dismissed
        delegate?.dialogDismissed()
        
    }
    
    
    

}
