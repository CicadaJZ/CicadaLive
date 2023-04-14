//
//  AnchorModel.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit

class AnchorModel: NSObject {
    @objc var room_id : Int = 0
    @objc var vertical_src : String = ""
    @objc var isVertical : Int = 0 //0电脑直播 1手机直播
    @objc var room_name : String = ""
    @objc var nickname : String = ""
    @objc var online : Int = 0
    @objc var anchor_city : String = ""

    init(dict: Dictionary<String, Any>) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
