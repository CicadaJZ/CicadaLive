//
//  NetworkTools.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

struct DecodableType: Decodable {
    let url: String
}

class NetworkTools {
    class func requestData(type: MethodType, URLString: String, parameters: [String : AnyObject]? = nil, finishedCallBack: @escaping ((_ result: Any) -> ())) {
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        AF.request(URLString, method: method, parameters: parameters).responseDecodable(of: DecodableType.self) { response in
            switch response.result {
            case .failure(let error):
                print(error)
                return
            case .success(_):
                finishedCallBack(response.result)
            }
        }
    }
}
