//
//  RecommendViewController.swift
//  CicadaLive
//
//  Created by  on 2023/4/14.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90


private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: BaseViewController {
    
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView: RecommendGameView = {
        let cycleView = RecommendGameView.recommendGameView()
        cycleView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return cycleView
    }()
    
    private lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //随父控件拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
    }
}

//MARK: 设置UI
extension RecommendViewController {
    override func setupUI() {
        //ani
        contenView = collectionView
        
        //
        view.addSubview(collectionView)
        
        //
        collectionView.addSubview(cycleView)
        
        //
        collectionView.addSubview(gameView)
        
        //
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        //
        super.setupUI()
    }
}

//MARK: 发送网络请求
extension RecommendViewController {
    private func loadData() {
        //
        recommendVM.requestData {
            //
            self.collectionView.reloadData()
            
            //
            self.gameView.groups = self.recommendVM.anchorGroups
            
            
            //停止loading
            self.loadDataFinished()
        }
        
        //
        recommendVM.requestCycleData {
            self.cycleView.cycleData = self.recommendVM.cycleData
        }
    }
}

//MARK: 遵循 UICollectionViewDelegateFlowLayout 协议
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)

        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}

//MARK: 遵循 UICollectionViewDelegate 协议
extension RecommendViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchorModel = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.row] 
        anchorModel.isVertical == 0 ? pushNormalRoomVC() : presentShowRoomVC()
    }
    
    func pushNormalRoomVC() {
        let normalRoomVC = RoomNormalViewController()
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
    
    func presentShowRoomVC() {
        let showRoomVC = RoomShowViewController()
        present(showRoomVC, animated: true)
    }
    
    
}


//MARK: 遵循 UICollectionViewDataSource 协议
extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.row]

        //
        var cell: CollectionBaseCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell

        }
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    
}

