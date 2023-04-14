//
//  NSDate-Extension.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/14.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }
}
