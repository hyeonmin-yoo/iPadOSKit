//
//  UIColorExtension.swift
//  iPadOSKit
//
//  Created by HYEONMIN YOO on 18/01/2025.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        if hexSanitized.count == 6 {
            let scanner = Scanner(string: hexSanitized)
            var rgbValue: UInt64 = 0
            scanner.scanHexInt64(&rgbValue)
            
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        } else {
            self.init(white: 1.0, alpha: 1.0)
        }
    }
}
