//
//  PagingCollectionViewFlowLayout.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/02.
//

import UIKit

final class PagingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0

    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
           guard let collectionView = collectionView else {
               return super.targetContentOffset(
                forProposedContentOffset: proposedContentOffset,
                withScrollingVelocity: velocity
               )
           }

           let itemsCount = collectionView.numberOfItems(inSection: 0)

           if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
               self.currentPage = max(self.currentPage - 1, 0)
           } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
               self.currentPage = min(self.currentPage + 1, itemsCount - 1)
           }

        let updatedOffset = (itemSize.width + minimumInteritemSpacing) * CGFloat(self.currentPage)
        self.previousOffset = updatedOffset

           return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
       }
}
