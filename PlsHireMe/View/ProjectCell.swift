//
//  ProjectCell.swift
//  PlsHireMe
//
//  Created by admin on 1/15/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class ProjectCell: UICollectionViewCell {
    var project: Project! {
        didSet {
            titleLabel.text = project.title
            imageView.image = UIImage(named: project.imageURL)
        }
    }
    
    let background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.97, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "playerIcon.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Shopify Matching Game"
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundView()
        setupImageView()
        setupTitleLabel()
        
    }
    
    func setupBackgroundView() {
        addSubview(background)
        background.layer.cornerRadius = 10
        background.layer.shadowColor = UIColor.black.cgColor
        background.layer.shadowOpacity = 0.5
        background.layer.shadowOffset = .zero
        background.layer.shadowRadius = 3
        background.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
