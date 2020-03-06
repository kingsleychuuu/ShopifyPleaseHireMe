//
//  ViewController.swift
//  PlsHireMe
//
//  Created by admin on 1/12/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let transition = CircularTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupButton()
    }
    
    func setupButton() {
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = button.frame.size.height/2
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = button.center
        transition.circleColor = button.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = button.center
        transition.circleColor = button.backgroundColor!
        return transition
    }
    
    @objc func buttonTapped() {
        let viewController = NewViewController()
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        present(viewController, animated: true, completion: nil)
    }
}
