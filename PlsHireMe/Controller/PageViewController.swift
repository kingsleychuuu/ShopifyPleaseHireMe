//
//  ViewController.swift
//  PlsHireMe
//
//  Created by admin on 1/11/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate {
    
    let pageCellID = "pageCellID"
    
    let pages = [
        Page(title: "Hello Shopify, I'm Glad You're Here :D",
             body: "I'm Kingsley, a 4th year Software Engineering student and here's an app to get to know more about me!",
             imageURL: "displayPicture.png"),
        Page(title: "Bridging the Gap Between Engineering and Business",
             body: "I'm always actively seeking opportunities to venture above and beyond school with innovative and unique app ideas (check out my github)!",
             imageURL: "role.png"),
        Page(title: "A Keen Passion for Clean Design",
             body: "By innovating on the physically smallest platform, efficient mobile UI/UX design is essential along with clean and beautiful code 🔥🔥🔥",
             imageURL: "logos.png"),
        Page(title: "All Code, No Fuss",
             body: "By creating pure programmatic applications, I make sure to focus on clear and simple code for collaboration and readability.",
             imageURL: "swiftCode.png")
    ]

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .black
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    let buttonsView = UIStackView()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(scrollToNext), for: .touchUpInside)
        return button
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var projectsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Projects", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(projectsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setInitialBackgroundColor()
        setupCollectionView()
        setupCellRegistration()
        setupButtonsView()
        setupPageControl()
    }
    
    func setInitialBackgroundColor() {
        collectionView.backgroundColor = UIColor.init(red: 150/255, green: 191/255, blue: 72/255, alpha: 0.5)
    }
    
    func changeBackgroundColor() {
        let red = CGFloat.random(in: 100...255)/255
        let green = CGFloat.random(in: 100...255)/255
        let blue = CGFloat.random(in: 100...255)/255
        let color = UIColor(red: red, green: green, blue: blue, alpha: 0.6)
        UIView.animate(withDuration: 1.0) {
            self.collectionView.backgroundColor = color
        }
    }
    
    func setupButtonsView() {
        buttonsView.addArrangedSubview(nextButton)
        buttonsView.addArrangedSubview(dividerView)
        buttonsView.addArrangedSubview(projectsButton)
        buttonsView.axis = .horizontal
        buttonsView.spacing = 0
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        buttonsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        buttonsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttonsView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nextButton.widthAnchor.constraint(equalTo: projectsButton.widthAnchor).isActive = true
        dividerView.widthAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupCellRegistration() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: pageCellID)
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = pages.count
        view.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: buttonsView.topAnchor).isActive = true
    }
    
    @objc func scrollToNext() {
        let currentCell = collectionView.visibleCells.first
        let index = collectionView.indexPath(for: currentCell!)?.item ?? 0
        
        if index < pages.count - 1 {
            let nextIndexPath = IndexPath(item: index + 1, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = index + 1
        }
        changeBackgroundColor()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCellID, for: indexPath) as! PageCell
        cell.page = pages[indexPath.row]
        cell.parentController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        changeBackgroundColor()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x/view.frame.width)
        pageControl.currentPage = pageNumber
    }
    
    @objc func projectsButtonTapped() {
        UIView.animate(withDuration: 0.2, animations: {
            self.collectionView.backgroundColor = UIColor.init(red: 150/255, green: 191/255, blue: 72/255, alpha: 0.5)
        }) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

