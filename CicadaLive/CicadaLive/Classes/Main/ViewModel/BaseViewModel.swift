//
//  BaseViewModel.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/15.
//

import UIKit

class BaseViewModel {

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()

    
}

extension BaseViewModel {
    
    func loadAnchorData(URLString: String, parameters: [String : Any],finishedCallBack: @escaping (() -> ())) {
        NetworkTools.requestData(type: .GET, URLString: URLString, parameters: parameters) { [weak self] result in
            guard let resultDic = result as? [String : Any] else { return }
            print(resultDic)

            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            for dict in dataArray {
                //kvc方式 字典转模型
                let group = AnchorGroup(dict: dict)
                self?.anchorGroups.append(group)
            }
            
//            for group in self.anchorGroups {
//                for anchor in group.anchors {
//                    print("aaa:\(anchor.nickname)")
//
//                }
//            }
            finishedCallBack()
        }
    }

    
}
