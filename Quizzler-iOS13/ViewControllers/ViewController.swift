//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    private var answer = bankOfQuestions.randomElement()
    private let numberOfTotalQuestions = bankOfQuestions.count
    private var numberOfQuestionsAnswered = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateQuestion()
    }


    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        if let buttonTitle = sender.titleLabel?.text, let questionIstrue = answer?.isTrue {
            sender.backgroundColor = handleButtonColorAccordingToAnswer(buttonLabelText: buttonTitle, answerIsTrue: questionIstrue)
        }
        
        handleWithProgressBar()
        
    }
    
    private func handleButtonColorAccordingToAnswer(buttonLabelText: String, answerIsTrue: Bool) -> UIColor{
        if buttonLabelText == "True" && answerIsTrue == true {
            return .green
        } else if  buttonLabelText == "False" && answerIsTrue == false {
            return .green
        } else {
            return .red
        }
    }
    
    @IBAction func restoreDefaultValues(_ sender: UIButton){

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)){
            sender.backgroundColor = .clear
            self.updateQuestion()
        }
    }
    
    
    private func updateQuestion(){
        self.answer = bankOfQuestions.randomElement()
        questionLabel.text = answer?.question
    }
    
    private func handleWithProgressBar(){
        self.numberOfQuestionsAnswered += 1
        var totalProgress = Float(numberOfQuestionsAnswered) / Float(numberOfTotalQuestions)
        progressBar.progress = totalProgress
        
        if totalProgress == 1.0 {
            
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(endGame), userInfo: nil, repeats: false)
            
            
        }
        
    }
    
    
    //Make an method ot show other screen with end game message and total score
    @objc func endGame(){
        //Make method here
        let endViewController =  UIViewController()
        endViewController.view.backgroundColor = .green
    
        let editTextEndingMessage = UITextView(frame: CGRect(x: 40.0, y: 90.0, width: 300.0, height: 30.0))
    
        editTextEndingMessage.text = "End Game. Play it again! ;)"
        editTextEndingMessage.tintColor = .orange
        editTextEndingMessage.textAlignment = .center
        editTextEndingMessage.backgroundColor = .green
        editTextEndingMessage.font = UIFont(name: "Arial Rounded MT Bold", size: 20.0)
        
        endViewController.view.addSubview(editTextEndingMessage)
        
        //Centralize with constrains
        editTextEndingMessage.contentInsetAdjustmentBehavior = .automatic
        editTextEndingMessage.center = self.view.center
        editTextEndingMessage.textAlignment = NSTextAlignment.justified
        
        navigationController?.pushViewController(endViewController, animated: true)
    }
    

    
    
}

