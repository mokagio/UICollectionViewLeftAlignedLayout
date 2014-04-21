
#import "UICollectionViewLeftAlignedLayout.h"

static const NSInteger kMaxCellSpacing = 9;

@implementation UICollectionViewLeftAlignedLayout

#pragma mark - UICollectionViewLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* currentItemAttributes =
    [super layoutAttributesForItemAtIndexPath:indexPath];
    
    // first item in the section
    if (indexPath.item == 0) return currentItemAttributes;
    
    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    
    // if current item is the first item on the line
    // the approach here is to take the current frame, left align it to the edge of the view
    // then stretch it the width of the collection view, if it intersects with the previous frame then that means it
    // is on the same line, otherwise it is on it's own new line
    CGRect currentFrame = currentItemAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(0,
                                              currentFrame.origin.y,
                                              self.collectionView.frame.size.width,
                                              currentFrame.size.height);

    if (!CGRectIntersectsRect(previousFrame, strecthedCurrentFrame)) {
        // make sure the first item on a line is left aligned
        CGRect frame = currentItemAttributes.frame;
        frame.origin.x = 0;
        currentItemAttributes.frame = frame;
        return currentItemAttributes;
    }

    CGRect frame = currentItemAttributes.frame;
    frame.origin.x = previousFrameRightPoint + self.minimumInteritemSpacing;
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}

@end
