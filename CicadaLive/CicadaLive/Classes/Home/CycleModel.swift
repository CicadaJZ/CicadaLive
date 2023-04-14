//
//  CycleModel.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit

class CycleModel: NSObject {

    @objc var title: String = ""
    @objc var pic_url: String = ""
    @objc var room: Dictionary<String, Any>? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    @objc var anchor: AnchorModel?

    init(dict: Dictionary<String, Any>) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
