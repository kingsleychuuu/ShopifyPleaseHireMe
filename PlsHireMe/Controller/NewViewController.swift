//
//  NewViewController.swift
//  PlsHireMe
//
//  Created by admin on 1/12/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    func setupButton() {
        
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = button.frame.size.width/2
    }
    
    @objc func buttonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
