//
//  RecommendViewModel.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var verticalGroup : AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    func requestData(finishedCallBack: @escaping (() -> ())) {
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        let dispatchGroup = DispatchGroup()
//        let queue = DispatchQueue.global()
//        queue.async(group: dispatchGroup, execute: DispatchWorkItem {
//
//        })
//
//        dispatchGroup.notify(queue: .main) {
//
//        }
        
        //1.推荐
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { [weak self] result in
            guard let resultDic = result as? Dictionary<String, Any> else { return }
            print(resultDic)

            guard let dataArray = resultDic["data"] as? [Dictionary<String, Any>] else { return }
            
            self?.bigDataGroup.tag_name = "热门"
            self?.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                //kvc方式 字典转模型
                let anchor = AnchorModel(dict: dict)
                self?.bigDataGroup.anchors.append(anchor)
                
            }
            dispatchGroup.leave()
        }
        
        //2.颜值
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { [weak self] result in
            guard let resultDic = result as? Dictionary<String, Any> else { return }
            print(resultDic)

            guard let dataArray = resultDic["data"] as? [Dictionary<String, Any>] else { return }
            
            self?.verticalGroup.tag_name = "颜值"
            self?.verticalGroup.icon_name = "home_header_phone"
            for dict in dataArray {
                //kvc方式 字典转模型
                let anchor = AnchorModel(dict: dict)
                self?.verticalGroup.anchors.append(anchor)
                
            }
            dispatchGroup.leave()
        }
        
        //3.热门
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { [weak self] result in
            guard let resultDic = result as? Dictionary<String, Any> else { return }
            print(resultDic)

            guard let dataArray = resultDic["data"] as? [Dictionary<String, Any>] else { return }
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
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main, work: DispatchWorkItem {
            self.anchorGroups.insert(self.verticalGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallBack()
        })
    }
}
