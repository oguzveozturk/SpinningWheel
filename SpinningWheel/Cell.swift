//
//  TriangleCell.swift
//  SpinningWheel
//
//  Created by Oguz on 26.06.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

final class Cell: UICollectionViewCell {
    
    var data: String? {
        didSet {
            guard let data = data else { return }
            imageView.image = UIImage(named: data)
        }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let path = UIBezierPath()
        let mask = CAShapeLayer()
        path.move(to: CGPoint(x: 0,y: 0))
        path.addLine(to: CGPoint(x: bounds.size.width-(bounds.size.width/2), y:bounds.size.height ))
        path.addLine(to: CGPoint(x: bounds.size.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = CGPoint(x: circularlayoutAttributes.anchorPoint.x, y: circularlayoutAttributes.anchorPoint.y)
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 1.1) * self.bounds.height
    }
    
    private func setupLayout() {
        backgroundColor = .white
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height*0.2),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
