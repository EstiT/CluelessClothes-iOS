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
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            return CGPoint.zero
        }
        
        guard let itemsCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0) else {
            return CGPoint.zero
        }
        
        if (previousOffset > collectionView.contentOffset.x) && (velocity.x < 0) {
            currentPage = max(currentPage - 1, 0)
        }
        else if (previousOffset < collectionView.contentOffset.x) && (velocity.x > 0.0) {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }
        
        let itemEdgeOffset:CGFloat = (collectionView.frame.width - itemSize.width -  minimumLineSpacing * 2) / 2
        let updatedOffset: CGFloat = (itemSize.width + minimumLineSpacing) *
                                        CGFloat(currentPage) -
                                        (itemEdgeOffset + minimumLineSpacing)
        
        previousOffset = updatedOffset;
        
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y);
    }

}
