//
//  TriangleCell.swift
//  SpinningWheel
//
//  Created by Oguz on 26.06.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

final class Cell: UICollectionViewCell {
    
     lazy var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.textColor = .white
        l.font = .systemFont(ofSize: 35, weight: .bold)
        return l
    }()
    
    private let path = UIBezierPath()

    override init(frame: CGRect) {
        super.init(frame: frame)
        triangleMask()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = CGPoint(x: circularlayoutAttributes.anchorPoint.x, y: circularlayoutAttributes.anchorPoint.y)

    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return path.contains(point)
    }
    
    private func triangleMask() {
        let mask = CAShapeLayer()
        path.move(to: CGPoint(x: 0,y: 0))
        path.addLine(to: CGPoint(x: bounds.size.width-(bounds.size.width/2), y:bounds.size.height ))
        path.addLine(to: CGPoint(x: bounds.size.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    private func setupLayout() {
        backgroundColor = UIColor(red: .random(in: 0...1),
                                  green: .random(in: 0...1),
                                  blue: .random(in: 0...1),
                                  alpha: 1.0)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: frame.height*0.2),
            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            label.widthAnchor.constraint(equalTo: label.heightAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
