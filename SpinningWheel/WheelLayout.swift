//
//  WheelLayout.swift
//  kombin
//
//  Created by Oguz on 5.08.2020.
//  Copyright © 2020 Improver Digital. All rights reserved.
//

import UIKit

final class WheelLayout: UICollectionViewLayout {
    
    private let itemSize = CGSize(width: UIScreen.main.bounds.width/2.679, height: UIScreen.main.bounds.width/2.21)
    
    private var anglePerItem: CGFloat {
        return atan(1)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.bounds.width,
                      height: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width)
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }
    
    private var attributesList = [CircularCollectionViewLayoutAttributes]()

    override func prepare() {
        super.prepare()
        let centerY = collectionView!.contentOffset.y + (collectionView!.bounds.height / 2.0)
        let totalItems = collectionView!.numberOfItems(inSection: 0)
        attributesList = (0..<totalItems).map { (i)
        -> CircularCollectionViewLayoutAttributes in
            
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: NSIndexPath(item: i, section: 0) as IndexPath)
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: self.collectionView!.bounds.midX, y: centerY)
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            attributes.anchorPoint = CGPoint(x: 0.5, y: 1.05)
            let ang = Int(attributes.angle*180/CGFloat.pi+45)
            attributes.isHidden = true
            if -75 <= ang && ang <= 290 {
                attributes.isHidden = false
            }
            
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    private var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ?
            CGFloat(collectionView!.numberOfItems(inSection: 0)-1) * anglePerItem : 0
    }
    
    var angle: CGFloat {
        let totalItems = CGFloat(collectionView!.numberOfItems(inSection: 0))
        let a = angleAtExtreme * collectionView!.contentOffset.y / (collectionViewContentSize.height*(max(totalItems-1,1))/totalItems)
        return -a + 20*CGFloat.pi/180
    }
}

final class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        didSet {
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: CircularCollectionViewLayoutAttributes =
            super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}
