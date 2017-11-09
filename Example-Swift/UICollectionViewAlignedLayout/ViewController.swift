import UIKit
import UICollectionViewLeftAlignedLayout

class ViewController: UIViewController {
	
	private let cellIdentifier = "Cell"
	private var timer: Timer!
	private var layout: UICollectionViewAlignedLayout!
	
	@IBOutlet private var collectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		layout = UICollectionViewAlignedLayout()
		layout.minimumLineSpacing = 10
		layout.minimumInteritemSpacing = 10
		layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
		layout.layoutDirection = .right
		collectionView.setCollectionViewLayout(layout, animated: true)
		
		timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ViewController.relayout), userInfo: nil, repeats: true)
	}
	
	@objc private func relayout() {
		let options = [UICollectionViewLayoutDirection.left, UICollectionViewLayoutDirection.right]
		layout.layoutDirection = options[Int(Int(arc4random()) % options.count)]
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		timer.invalidate()
	}

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		cell.backgroundColor = UIColor.white
		cell.layer.borderColor = UIColor.cyan.cgColor
		cell.layer.borderWidth = 2
		cell.layer.shouldRasterize = true
		cell.layer.rasterizationScale = UIScreen.main.scale
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return section == 0 ? 5 : 10
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let randomWidth = CGFloat(arc4random() % 120) + 60
		return CGSize(width: randomWidth, height: 60)
	}

}

