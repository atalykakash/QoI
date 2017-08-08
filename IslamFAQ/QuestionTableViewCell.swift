//
//  QuestionTableViewCell.swift
//  IslamFAQ
//
//  Created by Admin on 7/26/17.
//  Copyright © 2017 Adilkhan Khassanov. All rights reserved.
//

import UIKit
import EasyPeasy

class QuestionTableViewCell: UITableViewCell {
    
    let questionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.font = UIFont.risingSunRegular()
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        self.addSubview(questionLabel)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        questionLabel <- [
            Top(0),
            CenterX(0).to(self),
            Width(frame.width * 0.9),
            Height(frame.height)
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
