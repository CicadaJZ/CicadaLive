//
//  CollectionNormalCell.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    override var anchor : AnchorModel? {
        didSet {
            //将属性传递给父类
            super.anchor = anchor
            //
            roomNameLabel.text = anchor?.room_name

        }
    }


}
