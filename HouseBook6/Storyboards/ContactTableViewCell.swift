//
//  ContactTableViewCell.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactCellImg: UIImageView!
    @IBOutlet weak var contactCellLabel: UILabel!
    @IBOutlet weak var contactCellAccessory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
