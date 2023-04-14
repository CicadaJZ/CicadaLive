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
    class func requestData(type: MethodType, URLString: String, parameters: [String : Any]? = nil, finishedCallBack: @escaping ((_ result: Any) -> ())) {
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        AF.request(URLString, method: method, parameters: parameters).responseData { response in
            switch response.result {
            case .failure(let error):
                print(error)
                return
            case .success(let data):
                let jsonData = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                finishedCallBack(jsonData)
            }
        }
        
//        AF.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default).responseDecodable(of: DecodableType.self) { response in
//            switch response.result {
//            case .failure(let error):
//                print(error)
//                return
//            case .success(_):
//                finishedCallBack(response.result)
//            }
//        }
    }
}
