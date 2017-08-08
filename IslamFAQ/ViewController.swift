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
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
        NVActivityIndicatorView.DEFAULT_TYPE = .ballClipRotatePulse
    }
    
    private func setup() {
        self.automaticallyAdjustsScrollViewInsets = false

        mainView.didSelectDelegate = self
        view.addSubview(mainView)
        updateViewConstraints()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
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

extension ViewController: UISearchControllerDelegate,UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.mainView.reloadInputViews()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Book.parseSearchQuestions(text: searchText, completion: { (questions) in
            self.mainView.questions = questions
            self.mainView.tableView.reloadData()
        })
    }
}

