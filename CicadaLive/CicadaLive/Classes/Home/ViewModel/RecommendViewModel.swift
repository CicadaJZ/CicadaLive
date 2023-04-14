//
//  RecommendViewModel.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit

class RecommendViewModel {

}

extension RecommendViewModel {
    func requestData() {
        NetworkTools.requestData(type: .GET, URLString: "http://www.httpbin.org/get") { result in
            print(result)
        }
    }
}
