//
//  AnchorGroup.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit

class AnchorGroup: NSObject {
    @objc var room_list : [Dictionary<String, Any>]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                let anchorModel = AnchorModel(dict: dict)
                anchors.append(anchorModel)
            }
        }
    }

    @objc var tag_name : String = ""
    @objc var icon_name : String = "home_header_normal"
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()

    init(dict: Dictionary<String, Any>) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [Dictionary<String, Any>] {
                for dict in dataArray {
                    let anchorModel = AnchorModel(dict: dict)
                    anchors.append(anchorModel)
                }
            }
        }
    }
    */
}
