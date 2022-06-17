//
//  InputLabel.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/06.
//

import Foundation
import UIKit

class InputLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 25)
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 25)
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
