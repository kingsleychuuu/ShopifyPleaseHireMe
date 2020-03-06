//
//  PageCell.swift
//  PlsHireMe
//
//  Created by admin on 1/11/20.
//  Copyright © 2020 Kingsley. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    var parentController: PageViewController?
    var page: Page! {
        didSet {
            titleLabel.text = page.title
            bodyLabel.text = page.body
            imageView.image = UIImage(named: page.imageURL)
        }
    }
    let stackView = UIStackView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 35)
        label.numberOfLines = 0
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "displayPicture.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setupCellViews() {
        addSubview(imageView)
        imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.axis = .vertical
        stackView.spacing = 0
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 180).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -60).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellViews()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        if location.x < frame.width / 2 {
            reset()
        } else {
            animatePageOut()
        }
    }
    
    func animatePageOut() {
        animateLabelOut()
    }
    
    override func prepareForReuse() {
        reset()
    }
    
    func animateLabelOut(up: Bool = true, completion: (() -> ())? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: -30, y: -150 * (up ? 1 : -1))
            }, completion: { (_) in
                
            })
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.75, options: .curveEaseOut, animations: {
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            self.perform(#selector(self.advance), with: nil, afterDelay: 0.3)
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: -350 * (up ? 1 : -1))
                self.imageView.alpha = 0
                self.imageView.transform = CGAffineTransform(translationX: 0, y: -350 * (up ? 1 : -1))
            }, completion: { (_) in
                
            })
        }
    }
    
    @objc func advance() {
        self.parentController?.scrollToNext()
    }
    
    func reset() {
        titleLabel.transform = .identity
        titleLabel.alpha = 1
        bodyLabel.transform = .identity
        bodyLabel.alpha = 1
        imageView.transform = .identity
        imageView.alpha = 1
    }
}
