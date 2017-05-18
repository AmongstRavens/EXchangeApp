//
//  MainCollectionViewControllerLayout.swift
//  EXchangeApp
//
//  Created by Sergey on 4/22/17.
//  Copyright © 2017 Sergey. All rights reserved.
//

import Foundation
import UIKit

class OffersCollectionViewControllerLayout : UICollectionViewLayout{
    var contentInsets : UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
    var rowSpacing : CGFloat = 5
    var columnSpacing : CGFloat = 5
    private var contentWidth : CGFloat = UIScreen.main.bounds.size.width;
    private var contentHeight : CGFloat = 0;
    
    var delegate : OffersLayoutDelegate!
    var sizeBetweenItemsInSection : CGFloat = 10
    var cache = [OffersLayoutAttributes]()
    
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        contentWidth -= contentInsets.left + contentInsets.right
        var leftColumnY : CGFloat = contentInsets.top
        var rightColumnY : CGFloat = contentInsets.top
        if cache.isEmpty{
            if((collectionView?.numberOfItems(inSection: 0))! > 0){
                for item in 0...((collectionView?.numberOfItems(inSection: 0))! - 1){
                    let indexPath = IndexPath(item: item, section: 0)
                    let width = (contentWidth - rowSpacing) / 2
                    var imageHeight = delegate.collectionView(collectionView: collectionView!, heightForImageAtIndexPath: indexPath, withWidth: width)
                    var topLabelHeight = delegate.collectionView(collectionView: collectionView!, heightForTopLabelAtIndexPath: indexPath, withWidth: width - 60)
                    
                    let constraintsOffsets : CGFloat = 40
                    let botomViewHeight : CGFloat = 50
                    
                    var height = constraintsOffsets + botomViewHeight + imageHeight + topLabelHeight
                    
                    var origin : CGPoint!
                    var size : CGSize!
                    if(indexPath.item % 2 == 0){
                        let gridHeight : CGFloat = 20 - (leftColumnY + height).truncatingRemainder(dividingBy: 20)
                        height += gridHeight
                        imageHeight += gridHeight / 2
                        topLabelHeight += gridHeight / 2
                        origin = CGPoint(x: contentInsets.left, y: leftColumnY)
                        size = CGSize(width: width, height: height)
                        leftColumnY += height + columnSpacing
                    } else {
                        let gridHeight : CGFloat = 20 - (leftColumnY + height).truncatingRemainder(dividingBy: 20)
                        height += gridHeight
                        imageHeight += gridHeight / 2
                        topLabelHeight += gridHeight / 2
                        origin = CGPoint(x: contentInsets.left + width + rowSpacing, y: rightColumnY)
                        size = CGSize(width: width, height: height)
                        rightColumnY += height + columnSpacing
                    }
                    let frame = CGRect(origin: origin, size: size)
                    let attribute = OffersLayoutAttributes(forCellWith: indexPath)
                    attribute.imageHeight = imageHeight
                    attribute.topLabelheight = topLabelHeight
                    attribute.frame = frame
                    cache.append(attribute)
                }
            }
            contentHeight = max(leftColumnY, rightColumnY)
            contentHeight -= columnSpacing
            contentHeight += contentInsets.bottom
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [OffersLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    override class var layoutAttributesClass : AnyClass{
        return OffersLayoutAttributes.self
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
}

protocol OffersLayoutDelegate{
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView, heightForTopLabelAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    
}

class OffersLayoutAttributes  : UICollectionViewLayoutAttributes{
    var imageHeight : CGFloat = 0
    var topLabelheight : CGFloat = 0
    
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? OffersLayoutAttributes {
            if( attributes.imageHeight == imageHeight  && attributes.topLabelheight == topLabelheight) {
                return super.isEqual(object)
            }
        }
        return false
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! OffersLayoutAttributes
        copy.imageHeight = imageHeight
        copy.topLabelheight = topLabelheight
        return copy
    }
}

