//
//  CollectionGameCell.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : AnchorGroup? {
        didSet {
            iconImageView.kf.setImage(with: URL(string: group?.icon_url ?? ""), placeholder: UIImage(named: "home_more_btn"))
            titleLabel.text = group?.tag_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
