//
//  CollectionPrettyCell.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            //将属性传递给父类
            super.anchor = anchor
            //
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)

        }
    }
}
