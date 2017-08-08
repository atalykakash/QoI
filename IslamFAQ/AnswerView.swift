//
//  AnswerView.swift
//  IslamFAQ
//
//  Created by Admin on 8/4/17.
//  Copyright © 2017 Adilkhan Khassanov. All rights reserved.
//

import UIKit
import EasyPeasy

class AnswerView: UIView {
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    var question: Question? {
        didSet {
            if let questionText = question?.questionTitle, let answerText = question?.answerTitle {
                questionTextView.text = questionText
                questionTextView.sizeToFit()
                answerTextView.text = answerText
                answerTextView.sizeToFit()
                updateConstraints()
                scrollView.contentOffset.y = 10000
            }
        }
    }
    
    lazy var questionTextView: UITextView = {
        let textView = UITextView(frame: CGRect.zero)
        textView.backgroundColor = .white
        textView.textAlignment = .left
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 23)
        return textView
    }()
    
    lazy var answerTextView: UITextView = {
        let textView = UITextView(frame: CGRect.zero)
        textView.textAlignment = .left
        textView.font = UIFont.risingSunRegular()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = textView.font?.withSize(17)
        return textView
    }()
    
    func setup() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(questionTextView)
        self.scrollView.addSubview(answerTextView)
        self.backgroundColor = UIColor.white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        scrollView <- Edges()
        
        questionTextView <- [
            Top(66),
            Width(Constants.screenWidth * 0.95),
            Height(questionTextView.frame.height),
            CenterX(0).to(self)
        ]
        
        questionTextView.layoutIfNeeded()
        questionTextView.textAlignment = .center
        questionTextView.backgroundColor = .red
        
        answerTextView <- [
            Top().to(questionTextView),
            CenterX(0).to(self),
            Width(Constants.screenWidth * 0.95),
            Height(answerTextView.frame.height)
        ]
        
        answerTextView.layoutIfNeeded()
        
        scrollView.setContentOffset(CGPoint.zero, animated: false)
        scrollView.contentSize = CGSize(width: Constants.screenWidth * 0.8, height: answerTextView.frame.maxY + questionTextView.frame.maxY + 60)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
