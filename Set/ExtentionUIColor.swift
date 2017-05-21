//
//  ExtentionUIColor.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Create a UIColor instance by defining the individual rgb values as Int's randging from 0-255
    ///
    /// - Parameters:
    ///   - red: Int in a randge from 0 to 255
    ///   - green: Int in a randge from 0 to 255
    ///   - blue: Int in a randge from 0 to 255
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// Create a UIColor from a Integer hexadecimal representation of color (like: 0x5f42afd)
    ///
    /// - Parameter hexInt: like a css hexadecimal color representation but with 0x in stead of #
    convenience init(fromHexInt hexInt: Int) {
        self.init(red:(hexInt >> 16) & 0xff, green:(hexInt >> 8) & 0xff, blue:hexInt & 0xff)
    }
    
    
    /// The Integer hexadecimal representation of the UIColor instance
    var asHexInt: Int {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        
        return (Int)(fRed*255)<<16 | (Int)(fGreen*255)<<8 | (Int)(fBlue*255)<<0
    }
}
