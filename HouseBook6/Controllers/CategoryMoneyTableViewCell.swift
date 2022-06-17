//
//  CategoryMoneyTableViewCell.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/23.
//

import UIKit

class CategoryMoneyTableViewCell: UITableViewCell {

    @IBOutlet weak var subCategoryNameLabel: UILabel!
    @IBOutlet weak var subCategoryMoneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subCategoryNameLabel.adjustsFontSizeToFitWidth = true
        subCategoryMoneyLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
