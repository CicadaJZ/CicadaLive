//
//  RecommendCycleView.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit


private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {

    var timer : Timer?
    
    
    var cycleData: [CycleModel]? {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = cycleData?.count ?? 0
            
            //默认滚动到中间某一个位置，防止用户左滑滑倒第一个前面没有数据
            let indexPath = IndexPath(item: (cycleData?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
            
            removeTimer()
            addTimer()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = []
        
        //
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = false

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        layout.itemSize = collectionView.bounds.size
//        layout.scrollDirection = .horizontal
        
    }
    

}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleData?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cycleModel = cycleData![indexPath.item % cycleData!.count]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModel
        return cell
    }
    
    
    
}

extension RecommendCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //实现滑动一半时pagecontrol就选中下一个page
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5

//        let offsetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetX / scrollView.bounds.size.width) % (cycleData?.count ?? 1)
    }
    
    //开始拖拽时停止定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    //停止拖拽启动定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool ) {
        addTimer()
    }
}

//MARK: 定时器
extension RecommendCycleView {
    
    func addTimer() {
        timer = Timer(timeInterval: 3, repeats: true, block: { timer in
            let currentOffsetX = self.collectionView.contentOffset.x
            let offsetX = currentOffsetX + self.collectionView.bounds.width
            self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)

        })
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
}
