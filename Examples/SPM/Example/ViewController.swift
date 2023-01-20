import UICollectionViewLeftAlignedLayout
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private let reuseIdentifier = "reuseId" // Has to be different from the one in the storyboard
    private let shouldRefresh = true
    private lazy var timer: Timer = Timer(
        timeInterval: 0.5,
        target: self,
        selector: #selector(reloadData),
        userInfo: .none,
        repeats: true
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(UICollectionViewLeftAlignedLayout(), animated: false)
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        guard shouldRefresh else { return }
        
        RunLoop.main.add(timer, forMode: .default)
    }
    
    @objc func reloadData() {
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection index: Int) -> Int {
        index == 0 ? 20 : 80
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.contentView.layer.borderColor = UIColor.blue.cgColor
        cell.contentView.layer.borderWidth = 2;
        return cell
    }
}

extension ViewController: UICollectionViewDelegateLeftAlignedLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let randomWidth: CGFloat = CGFloat((arc4random() % 120) + 60)
        return CGSize(width: randomWidth, height: 60)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt index: Int
    ) -> CGFloat {
        index == 0 ? 15 : 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        insetForSectionAt index: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
