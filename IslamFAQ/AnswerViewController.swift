//
//  AnswerViewController.swift
//  IslamFAQ
//
//  Created by Galymzhan Koptleuov on 7/17/17.
//  Copyright © 2017 Adilkhan Khassanov. All rights reserved.
//

import UIKit
import EasyPeasy

class AnswerViewController: UIViewController {
    
    var question = Question(question: "", answer: "")
    
    lazy var answerView: AnswerView = {
        let answerView = AnswerView()
        return answerView
    }()
    
    func setup() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(answerView)
        answerView.question = question
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationItem.title = question.questionTitle
        self.navigationController?.navigationBar.backItem?.title = ""
        
        answerView <- Edges()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
