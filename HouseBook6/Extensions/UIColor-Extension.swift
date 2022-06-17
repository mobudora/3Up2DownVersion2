//
//  UIColor-Extension.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit

extension UIColor
{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
    {
        return self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}

struct Colors
{
    let whiteGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    let gray = UIColor(red: 183/255, green: 176/255, blue: 176/255, alpha: 1)
    let darkGray = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
    let white = UIColor(red: 255, green: 255, blue: 255, alpha: 0.9)
    let black = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
    let red = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
    let pastelPink = UIColor(red: 247/255, green: 218/255, blue: 217/255, alpha: 1)
    let peachPink = UIColor(red: 255/255, green: 232/255, blue: 223/255, alpha: 1)
}

