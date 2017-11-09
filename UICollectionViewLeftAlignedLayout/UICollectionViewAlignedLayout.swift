// Copyright © 2014 Giovanni Lodi
// Copyright © 2017 Benjamin Yan Jurgis Dietzkis
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

import UIKit

public enum UICollectionViewLayoutDirection {
	case left
	case right
}

open class UICollectionViewAlignedLayout: UICollectionViewFlowLayout {
	
	/// The direction of layout
	///
	/// - left: all items are pinned to the left
	/// - right: all items are pinned to the right
	open var layoutDirection: UICollectionViewLayoutDirection = .left {
		didSet {
			collectionView?.performBatchUpdates({ [weak self] in
				self?.invalidateLayout()
			})
		}
	}
	
	/// The attributes for the elements within a certain rect
	///
	/// - Note: `representedElementKind` is `nil` for a cell, and we only want to modify cells.
	///
	/// - Parameter rect: the rect for the currently visible items
	/// - Returns: the modified attributes to use in the layout
	open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		return super.layoutAttributesForElements(in: rect)?
			.filter({ $0.representedElementKind == nil })
			.flatMap({ layoutAttributesForItem(at: $0.indexPath) })
	}
	
	/// The attributes for a given item
	///
	/// You should *always* `copy()` attributes before mutating them to ensure correct behaviour.
	///
	/// - Parameter indexPath: the location of the `item` in `section`
	/// - Returns: the attributes for the given item
	open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard
			let currentAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes,
			let collectionView = collectionView
			else { return nil }
		
		let previousIndex = IndexPath(item: indexPath.item - 1, section: indexPath.section)
		let currentFrame = currentAttributes.frame
		let layoutWidth = collectionView.frame.width - sectionInset.left - sectionInset.right
		
		switch layoutDirection {
		case .left:
			if indexPath.item > 0, let previousFrame = layoutAttributesForItem(at: previousIndex)?.frame,
				currentFrame.intersects(CGRect(x: sectionInset.left, y: previousFrame.origin.y, width: layoutWidth, height: previousFrame.size.height)) {
				currentAttributes.frame.origin.x = previousFrame.origin.x + previousFrame.size.width + minimumInteritemSpacing
			} else {
				currentAttributes.frame.origin.x = sectionInset.left
			}
		case .right:
			if indexPath.item > 0, let previousFrame = layoutAttributesForItem(at: previousIndex)?.frame,
				previousFrame.intersects(CGRect(x: sectionInset.left, y: currentFrame.origin.y, width: layoutWidth, height: currentFrame.size.height)) {
				currentAttributes.frame.origin.x = previousFrame.origin.x - currentFrame.size.width - minimumInteritemSpacing
			} else {
				currentAttributes.frame.origin.x = collectionView.frame.size.width - currentFrame.size.width - sectionInset.right
			}
		}
		
		return currentAttributes
		
	}
	
}
