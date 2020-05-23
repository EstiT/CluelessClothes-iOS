//
//  WLCollectionViewLayout.swift
//  Clueless Clothes
//
//  Created on 2019-09-18.
//  https://gist.githubusercontent.com/ylem/9158e1e3ad14958202adc6db7f6ec448/raw/5d43151b2558634002c1b8e6e320ff5d736372cb/CenterItemInCollectionView.playground
//

import Foundation
import UIKit

class WLCollectionViewLayout: UICollectionViewFlowLayout {
    
    var previousOffset: CGFloat    = 0
    var currentPage: Int           = 0
    
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override func prepare() {
    }
    
    func setup() {
        // setting up some inherited values
//        let space: CGFloat = 30
        //let w = view.frame.width
        /*
        let width = UIScreen.main.bounds.width
        let itemWidth = width - space * 4 // w0 == ws
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
        self.minimumInteritemSpacing = space
        self.minimumLineSpacing = space
        self.scrollDirection = .horizontal
 */
        
        
        //let itemWidth                       = w - space * 4 // w0 == ws
        //self.itemSize           = CGSize(width: itemWidth, height: 180)
        //self.minimumLineSpacing = space
        
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            return CGPoint.zero
        }
        
        guard let itemsCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0) else {
            return CGPoint.zero
        }
        
        if ((previousOffset > collectionView.contentOffset.x) && (velocity.x < 0)) {
            currentPage = max(currentPage - 1, 0)
        }
        else if ((previousOffset < collectionView.contentOffset.x) && (velocity.x > 0.0)) {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }
        
        let itemEdgeOffset:CGFloat = 30//(collectionView.frame.width - itemSize.width -  minimumLineSpacing * 2) / 2
        let updatedOffset: CGFloat = (itemSize.width + minimumLineSpacing) *
                                        CGFloat(currentPage) -
                                        (itemEdgeOffset + minimumLineSpacing)
        
        previousOffset = updatedOffset;
        
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y);
    }
    
    /*
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes: [AnyObject] = super.layoutAttributesForElements(in: rect)!
        let newAttributes: NSMutableArray = NSMutableArray(capacity: attributes.count)
        for attribute in attributes {
            if (attribute.frame.origin.x+attribute.frame.size.width <= self.collectionViewContentSize.width) && (attribute.frame.origin.y+attribute.frame.size.height <= self.collectionViewContentSize.height) {
                newAttributes.add(attribute)
            }
        }
        return newAttributes as? [UICollectionViewLayoutAttributes]

    }*/
}
