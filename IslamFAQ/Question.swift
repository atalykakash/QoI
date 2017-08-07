//
//  Question.swift
//  IslamFAQ
//
//  Created by Galymzhan Koptleuov on 7/16/17.
//  Copyright © 2017 Adilkhan Khassanov. All rights reserved.
//

import Foundation

struct Question {
    let questionTitle: String?
    let answerTitle: String?
    
    init(question: String, answer: String) {
        self.answerTitle = answer
        self.questionTitle = question
    }
}
