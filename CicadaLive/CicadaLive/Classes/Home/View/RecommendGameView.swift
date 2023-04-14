//
//  RecommendGameView.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetsMargin : CGFloat = 10
class RecommendGameView: UIView {

    var groups : [AnchorGroup]? {
        didSet {
            groups?.removeFirst()
            groups?.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = []
        
 
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)

        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetsMargin, bottom: 0, right: kEdgeInsetsMargin)


    }
    
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = groups![indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = group
        return cell
    }
    
    
    
}
