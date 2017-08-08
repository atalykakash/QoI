//
//  TopicTableView.swift
//  IslamFAQ
//
//  Created by Admin on 7/26/17.
//  Copyright © 2017 Adilkhan Khassanov. All rights reserved.
//

import UIKit
import EasyPeasy
import AnimatedCollectionViewLayout
import NVActivityIndicatorView

protocol DidSelect: class {
    func selectedRow(question: Question)
}

class MainView: UIView{
    
    var books: [Book] = [Book(title: "Principles of Belief", image: "belief"),
                         Book(title: "Islam", image: "cami"),
                         Book(title: "Metaphysics", image: "metaphysics"),
                         Book(title: "Human", image: "man"),
                         Book(title: "Creation", image: "creation"),
                         Book(title: "Fiqh", image: "fiqh"),
                         Book(title: "Miscellaneous", image: "miscellaneous"),
                         Book(title: "About", image: "aboutus")]
    
    var questions: [Question] = []
    weak var didSelectDelegate: DidSelect?
    
    lazy var picImageView : UIImageView = {
        let picImageView = UIImageView()
        picImageView.contentMode = .scaleAspectFill
        picImageView.image = UIImage(named: "cami")
        return picImageView
    }()
    
    lazy var layout: AnimatedCollectionViewLayout = {
        let layout = AnimatedCollectionViewLayout()
        let width: CGFloat = Constants.screenWidth
        let height: CGFloat = Constants.screenHeight
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: width, height: height*0.5)
        layout.scrollDirection = .horizontal
        layout.animator = LinearCardAttributesAnimator()
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(BooksCollectionViewCell.self, forCellWithReuseIdentifier: "TopicCell")
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        tableView.rowHeight = Constants.screenHeight * 0.1
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = Constants.screenHeight * 0.5
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(picImageView)
        self.addSubview(collectionView)
        self.addSubview(tableView)
        
        parseAllQuestions()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        picImageView <- [
            Top(0),
            Left(0),
            Width(Constants.screenWidth),
            Height(Constants.screenHeight * 0.5)
        ]
        
        collectionView <- [
            Top(0),
            Left(0),
            Width(Constants.screenWidth),
            Height(Constants.screenHeight * 0.5)
        ]
        
        tableView <- [
            Top(0).to(collectionView),
            Left(0),
            Width(Constants.screenWidth),
            Height(Constants.screenHeight * 0.5)
        ]
    }
    
    private func parseAllQuestions() {
        Book.parseAllQuestions { (questions) in
            self.questions = questions
            self.tableView.reloadData()
        }
    }
    
    func parseQuestions(topic: String, completion: @escaping () -> ()) {
        Book.parseQuestions(topic: topic) { (questions) in
            self.questions = questions
            self.tableView.reloadData()
            completion()
        }
    }

}

extension MainView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionTableViewCell
        
        cell.questionLabel.text = questions[indexPath.row].questionTitle
        
        return cell
    }
}

extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectDelegate?.selectedRow(question: questions[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainView: UICollectionViewDelegate, NVActivityIndicatorViewable {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 7) {
            UIApplication.shared.open(NSURL(string: "http://www.questionsonislam.com/authors")! as URL, options: [:], completionHandler: nil)
        }
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        if let title = books[indexPath.row].title {
                parseQuestions(topic: title, completion: {
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                })
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndex = collectionView.indexPathForItem(at: visiblePoint)
        
        picImageView.image = UIImage(named: books[(visibleIndex?.row)!].image!)
    }
}

extension MainView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCell", for: indexPath) as! BooksCollectionViewCell
        
        cell.titleLabel.text = books[indexPath.row].title
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        cell.picImageView.image = UIImage(named: books[indexPath.row].image!)
        cell.layer.cornerRadius = 5
        cell.activityIndicatorView.stopAnimating()
        
        return cell
    }
}

extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(frame.height * 0.08, 0, 0, 0)
    }
}


