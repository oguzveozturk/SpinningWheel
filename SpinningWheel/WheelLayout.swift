//
//  WheelLayout.swift
//  SpinningWheel
//
//  Created by Oguz on 26.06.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

final class WheelLayout: UICollectionViewLayout {
    
    private let itemSize = CGSize(width: UIScreen.main.bounds.width/2.679, height: UIScreen.main.bounds.width/2.21)

    private var radius: CGFloat = 100 {
        didSet {
            invalidateLayout()
        }
    }
    
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
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        let centerY = collectionView!.contentOffset.y + (collectionView!.bounds.height / 2.0)
        attributesList = (0..<collectionView!.numberOfItems(inSection: 0)).map { (i)
        -> CircularCollectionViewLayoutAttributes in
            
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: NSIndexPath(item: i, section: 0) as IndexPath)
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: self.collectionView!.bounds.midX, y: centerY)
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
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
            CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.y / (collectionViewContentSize.height -
            collectionView!.bounds.height)
    }
}

final class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        didSet {
            zIndex = Int(angle * 1000000)
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
