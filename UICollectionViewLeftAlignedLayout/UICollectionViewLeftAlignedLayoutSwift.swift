
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

private extension UICollectionViewLayoutAttributes {
    func leftAlignFrame(with sectionInset: UIEdgeInsets) {
        var frame = self.frame
        frame.origin.x = sectionInset.left
        self.frame = frame
    }
}

public class UICollectionViewLeftAlignedLayoutSwift: UICollectionViewFlowLayout {
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard var attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        for i in 0..<attributes.count {
            let currentAttributes = attributes[i]
            if currentAttributes.representedElementKind == nil {
                if let newAttributes = layoutAttributesForItem(at: currentAttributes.indexPath) {
                    attributes[i] = newAttributes
                }
            }
        }

        return attributes
    }

    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard
            let collectionView = collectionView,
            let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)
            else { return nil }

        let sectionInset = evaluatedSectionInsetForItem(at: indexPath.section)

        let isFirstItemInSection: Bool = indexPath.item == 0
        let layoutWidth: CGFloat = collectionView.frame.width - sectionInset.left - sectionInset.right

        if isFirstItemInSection {
            currentItemAttributes.leftAlignFrame(with: sectionInset)
            return currentItemAttributes
        }

        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)

        guard let previousFrame: CGRect = layoutAttributesForItem(at: previousIndexPath)?.frame else { return currentItemAttributes }

        let previousFrameRightPoint: CGFloat = previousFrame.origin.x + previousFrame.size.width
        let currentFrame: CGRect = currentItemAttributes.frame
        let stretchedCurrentFrame = CGRect(
            x: sectionInset.left,
            y: currentFrame.origin.y,
            width: layoutWidth,
            height: currentFrame.size.height
        )

        let isFirstItemInRow: Bool = !previousFrame.intersects(stretchedCurrentFrame)

        if isFirstItemInRow {
            currentItemAttributes.leftAlignFrame(with: sectionInset)
            return currentItemAttributes
        }

        var frame = currentItemAttributes.frame
        frame.origin.x = previousFrameRightPoint + evaluatedMinimumInteritemSpacingForSection(at: indexPath.section)
        currentItemAttributes.frame = frame
        return currentItemAttributes
    }

    private func evaluatedMinimumInteritemSpacingForSection(at index: Int) -> CGFloat {
        guard
            let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else { return 0 }

        return delegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: index) ?? minimumInteritemSpacing
    }

    private func evaluatedSectionInsetForItem(at index: Int) -> UIEdgeInsets {
        guard
            let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else { return .zero }

        return delegate.collectionView?(collectionView, layout: self, insetForSectionAt: index) ?? sectionInset
    }
}
