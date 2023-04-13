//
//  UIColor-Extension.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/13.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
