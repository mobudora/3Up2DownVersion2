//
//  CalendarDateLabel.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/04.
//

import Foundation
import UIKit

enum BorderPosition {
    case top
    case left
    case right
    case bottom
}

class CalendarLabel: UILabel {
    //DateDiaryCollectionViewCellの見出し
    init(heading: String) {
        super.init(frame: .zero)
        self.text = heading
        self.textColor = .black
        self.font = UIFont(name: "XANO-mincho", size: 14)
        self.textAlignment = .center
        self.adjustsFontSizeToFitWidth = true
//        self.anchor(width: UIScreen.main.bounds.width / 3)
    }
    //DateDiaryCollectionViewCellの中身
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.textColor = .black
        self.font = UIFont(name: "XANO-mincho", size: 14)
        self.textAlignment = .center
        self.adjustsFontSizeToFitWidth = true
//        self.anchor(width: UIScreen.main.bounds.width / 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBorder(borderWidth: CGFloat, color: UIColor, position: BorderPosition) {
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch position {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: borderWidth)
            self.layer.addSublayer(border)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.height)
            self.layer.addSublayer(border)
        case .right:
            border.frame = CGRect(x: self.frame.width - borderWidth, y: 0, width: borderWidth, height: self.frame.height)
            self.layer.addSublayer(border)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth)
            self.layer.addSublayer(border)
        }
    }
    func addDottedBorder(dottedBorderWidth: CGFloat, color: UIColor, position: BorderPosition) {

        let dottedBorder = CAShapeLayer()
        dottedBorder.fillColor = UIColor.clear.cgColor
        dottedBorder.strokeColor = color.cgColor
        dottedBorder.lineWidth = dottedBorderWidth
        dottedBorder.lineDashPattern = [2, 2]
        let path = CGMutablePath()
        
        switch position {
            
        case .top:
            path.move(to: CGPoint(x: 0.0, y: 0.0))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
            dottedBorder.path = path
        case .left:
            path.move(to: CGPoint(x: 0.0, y: 0.0))
            path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
            dottedBorder.path = path
        case .right:
            path.move(to: CGPoint(x: self.frame.size.width, y: 0.0))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
            dottedBorder.path = path
        case .bottom:
            path.move(to: CGPoint(x: 0.0, y: 0.0))
            path.addLine(to: CGPoint(x: self.frame.size.height, y: self.frame.size.width))
            dottedBorder.path = path
        }
        self.layer.addSublayer(dottedBorder)
    }
}
