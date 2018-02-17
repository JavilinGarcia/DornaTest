//
//  UIColor+Extension
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init?(hex: Int, alpha: Float) {
        var hexString = String(format: "%2X", hex)
        let leadingZerosString = String(repeating: "0", count: 6 - hexString.count)
        hexString = leadingZerosString + hexString
        self.init(hex: hexString)
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

