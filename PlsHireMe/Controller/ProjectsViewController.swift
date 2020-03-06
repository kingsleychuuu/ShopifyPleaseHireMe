//
//  ProjectsViewController.swift
//  PlsHireMe
//
//  Created by admin on 1/15/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class ProjectsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate {
    let projectCellID = "projectCellID"
    
    let projects = [
        Project(title: "Music Visualizer", imageURL: "playerIcon.png"),
        Project(title: "Matching Game", imageURL: "matchIcon.png"),
        Project(title: "Wordsearch Game", imageURL: "wordSearchIcon.png")
    ]
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCellRegistration()
        setupProjectCollectionView()
    }
    
    func setupCellRegistration() {
        self.collectionView!.register(ProjectCell.self, forCellWithReuseIdentifier: projectCellID)
    }
    
    func setupProjectCollectionView() {
        collectionView.backgroundColor = .white
        title = "Projects"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More!", style: .plain, target: self, action: #selector(moreButtonTapped))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectCellID, for: indexPath) as! ProjectCell
        cell.project = projects[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20, height: view.frame.height/4)
    }
    
    @objc func moreButtonTapped() {
        let pageViewController = PageViewController()
        pageViewController.transitioningDelegate = self
        pageViewController.modalPresentationStyle = .custom
        present(pageViewController, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint(x: view.frame.width, y: 0)
        transition.circleColor = UIColor.init(red: 150/255, green: 191/255, blue: 72/255, alpha: 0.5)
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: view.frame.width, y: 0)
        transition.circleColor = .black
        return transition
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = SongLibraryViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = MatchingConfigViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            let viewController = WordsearchViewController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
