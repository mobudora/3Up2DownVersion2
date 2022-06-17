//
//  CalendarImageView.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/04.
//
import Foundation
import UIKit

class CalendarImageView: UIImageView {
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        self.image = UIImage(systemName: imageName)
        self.contentMode = .scaleAspectFit
        self.tintColor = .black
        self.anchor(centerY: centerYAnchor, centerX: centerXAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
