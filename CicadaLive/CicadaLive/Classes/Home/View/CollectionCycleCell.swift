//
//  CollectionCycleCell.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            iconImageView.kf.setImage(with: URL(string: cycleModel?.pic_url ?? ""))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
