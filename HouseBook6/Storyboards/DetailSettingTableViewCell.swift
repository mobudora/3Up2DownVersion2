//
//  DetailSettingTableViewCell.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit

class DetailSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var generalImg: UIImageView!
    @IBOutlet weak var generalLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
