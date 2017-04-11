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
//  ViewController.swift
//  Example
//
//  Created by Yuki Nagai on 5/11/16.
//

import UIKit
import SnapKit

import CollectionViewLeftAlignedLayout


private let flatBelizeHoleColor = UIColor(red: 0.1607843137254902, green: 0.5019607843137255, blue: 0.7254901960784313, alpha: 1)
private let flatPeterRiverColor = UIColor(red: 0.20392156862745098, green: 0.596078431372549, blue: 0.8588235294117647, alpha: 1)

final class ViewController: UIViewController {
    let cellIdentifier = "CellIdentifier"
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Add Subviews
        let titleLabel = UILabel()
        self.view.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { make in
            let view = self.view
            let offset = 8
            make.top.equalTo(view).offset(offset)
            make.leading.equalTo(view).offset(offset)
            make.trailing.equalTo(view).offset(-offset)
        }
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: CollectionViewLeftAlignedLayout())
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints { make in
            let view = self.view
            let offset = 8
            make.top.equalTo(titleLabel.snp_bottom).offset(offset)
            make.bottom.equalTo(view).offset(-offset)
            make.leading.equalTo(view).offset(offset)
            make.trailing.equalTo(view).offset(-offset)
        }
        
        // Configure
        titleLabel.text = "Left Aligned UICollectionView Layout"
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFontOfSize(25)
        titleLabel.textColor = flatBelizeHoleColor
        titleLabel.lineBreakMode = .ByWordWrapping
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clearColor()
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 20 : 80
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.contentView.layer.borderColor = flatPeterRiverColor.CGColor
        cell.contentView.layer.borderWidth = 2
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: CollectionViewDelegateLeftAlignedLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = CGFloat(arc4random() % 120) + 60
        return CGSize(width: width, height: 60)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return section == 0 ? 15 :5
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
