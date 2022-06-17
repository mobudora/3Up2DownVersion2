//
//  CalendarStackView.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/11.
//

import Foundation
import UIKit

class CalendarStackView: UIStackView {

    init(direction: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        self.axis = direction
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(direction: NSLayoutConstraint.Axis, divisionWidth: CGFloat) {
        super.init(frame: .zero)
        self.axis = direction
        self.translatesAutoresizingMaskIntoConstraints = false
        self.anchor(width: UIScreen.main.bounds.width / divisionWidth - 2)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
