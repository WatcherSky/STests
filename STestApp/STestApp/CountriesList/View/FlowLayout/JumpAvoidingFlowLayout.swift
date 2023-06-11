//
//  JumpAvoidingFlowLayout.swift
//  STestApp
//
//  Created by Владимир on 15.05.2023.
//

import UIKit

class JumpAvoidingFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let targetX: CGFloat = {
            let totalHorizontalInset = collectionView.contentInset.right + collectionView.contentInset.left
            let totalWidth = collectionViewContentSize.width + totalHorizontalInset
            
            
            if totalWidth > collectionView.bounds.size.width {
                return proposedContentOffset.x
            }
            
            return 0
        }()
        
        let targetY: CGFloat = {
            let totalVerticalInset = collectionView.contentInset.top + collectionView.contentInset.bottom
            let totalHeight = collectionViewContentSize.height + totalVerticalInset
            
            if totalHeight > collectionView.bounds.size.height {
                return proposedContentOffset.y
            }
            
            return 0
        }()
        
        return CGPoint(x: targetX, y: targetY)
    }
}
