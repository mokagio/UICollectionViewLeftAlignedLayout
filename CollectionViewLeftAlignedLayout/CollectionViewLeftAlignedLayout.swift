// Copyright (c) 2014 Giovanni Lodi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  CollectionViewLeftAlignedLayout.swift
//  CollectionViewLeftAlignedLayout
//
//  Created by Yuki Nagai on 5/11/16.
//

import UIKit

/**
 Simple UICollectionViewFlowLayout that aligns the cells to the left rather than justify them
 
 Based on [stack overflow](http://stackoverflow.com/questions/13017257/how-do-you-determine-spacing-between-cells-in-uicollectionview-flowlayout)
 */
public final class CollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
    public override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElementsInRect(rect)?
            .map { $0.copy() as! UICollectionViewLayoutAttributes }
            .map { attributes in
                guard attributes.representedElementKind == nil else { return attributes }
                let indexPath = attributes.indexPath
                if let frame = self.layoutAttributesForItemAtIndexPath(indexPath)?.frame {
                    attributes.frame = frame
                }
            return attributes
        }
    }
    
    public override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView,
            currentAttributes = super.layoutAttributesForItemAtIndexPath(indexPath)?.copy() as? UICollectionViewLayoutAttributes
            else { return nil }
        let sectionInset = self.evaluatedSectionInsetForItemAtIndex(indexPath.section)
        guard indexPath.item > 0 else { return currentAttributes.leftAlignedWithSectionInset(sectionInset) }
        let previousIndexPath = NSIndexPath(forItem: indexPath.item - 1, inSection: indexPath.section)
        guard let previousFrame = layoutAttributesForItemAtIndexPath(previousIndexPath)?.frame else { return nil }
        let currentFrame = CGRect(
            x: sectionInset.left,
            y: currentAttributes.frame.origin.y,
            width: collectionView.frame.width - sectionInset.left + sectionInset.right,
            height: currentAttributes.frame.size.height)
        guard CGRectIntersectsRect(previousFrame, currentFrame) else { return currentAttributes.leftAlignedWithSectionInset(sectionInset) }
        currentAttributes.frame.origin.x = previousFrame.origin.x + previousFrame.size.width + self.evaluatedMinimumInteritemSpacingForSectionAtIndex(indexPath.section)
        return currentAttributes
    }
    
    private func evaluatedSectionInsetForItemAtIndex(index: Int) -> UIEdgeInsets {
        if let collectionView = collectionView,
            delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            sectionInset = delegate.collectionView?(collectionView, layout: self, insetForSectionAtIndex: index) {
            return sectionInset
        }
        return self.sectionInset
    }
    
    private func evaluatedMinimumInteritemSpacingForSectionAtIndex(index: Int) -> CGFloat {
        if let collectionView = collectionView,
            delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            minimumInteritemSpacing = delegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAtIndex: index) {
            return minimumInteritemSpacing
        }
        return self.minimumInteritemSpacing
    }
}

extension UICollectionViewLayoutAttributes {
    private func leftAlignedWithSectionInset(sectionInset: UIEdgeInsets) -> UICollectionViewLayoutAttributes {
        let copy = self.copy() as! UICollectionViewLayoutAttributes
        copy.frame.origin.x = sectionInset.left
        return copy
    }
}
