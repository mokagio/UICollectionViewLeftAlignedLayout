UICollectionView Left Aligned Layout
====================================

A `UICollectionViewLayout` implementation that aligns the cells to the left. 

<img src="https://raw.githubusercontent.com/mokagio/UICollectionViewLeftAlignedLayout/master/screenshot.png" />

_Check out the twin project [`UICollectionViewRightAlignedLayout`](https://github.com/mokagio/UICollectionViewRightAlignedLayout)_

## Installation with CocoaPods

```ruby
platform :ios, '6.0'

pod 'UICollectionViewLeftAlignedLayout'
```

## Usage

Simply set `UICollectionViewLeftAlignedLayout` as the layout object for your collection view either via code:

```objc
CGRect frame = ...
UICollectionViewLeftAlignedLayout *layout = [UICollectionViewLeftAlignedLayout alloc] init];
UICollectionView *leftAlignedCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
```

or from Interface Builder:

_img needed here_

`UICollectionViewLeftAlignedLayout` is a subclass of `UICollectionViewFlowLayout`, so your collection view delegate can use all the delegate methods of [`UICollectionViewDelegateFlowLayout`](https://developer.apple.com/library/ios/documentation/uikit/reference/UICollectionViewDelegateFlowLayout_protocol/Reference/Reference.html).

For those of you who like consistency there is an `UICollectionViewDelegateLeftAlignedLayout` protocol that your delegate object can conform to. Is nothing more than an empty extension of `UICollectionViewDelegateFlowLayout`.

## License

`UICollectionViewLeftAlignedLayout` is released under the [MIT license](https://github.com/mokagio/UICollectionViewLeftAlignedLayout/blob/master/LICENSE).

---

Hacked together with passion by [@mokagio](https://twitter.com/mokagio)
