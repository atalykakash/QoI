//
//  ViewController.swift
//  IslamFAQ
//
//  Created by Galymzhan Koptleuov on 7/13/17.
//  Copyright © 2017 Adilkhan Khassanov. All rights reserved.
//

import UIKit
import EasyPeasy
import AnimatedCollectionViewLayout
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    let mainView : MainView = {
        let mainView = MainView()
        return mainView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        NVActivityIndicatorView.DEFAULT_TYPE = .ballClipRotatePulse
    }
    
    private func setup() {
        self.automaticallyAdjustsScrollViewInsets = false

        mainView.didSelectDelegate = self
        view.addSubview(mainView)
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        mainView <- [
            Edges(0)
        ]
    }
}

extension ViewController: DidSelect {
    func selectedRow(question: Question) {
        let vc = AnswerViewController()
        vc.question = question
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


