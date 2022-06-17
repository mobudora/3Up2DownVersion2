//
//  InputButton.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/06.
//

import Foundation
import UIKit

class InputButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.tintColor = .black
        self.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle("\(title)", for: .normal)
        self.backgroundColor = .rgb(red: 117, green: 117, blue: 117, alpha: 0.1)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    init(image: UIImage) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        config.baseForegroundColor = .black
        self.tintColor = .rgb(red: 117, green: 117, blue: 117, alpha: 0.1)
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        self.configuration = config
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
