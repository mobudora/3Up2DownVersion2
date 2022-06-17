//
//  incomeTableViewCell.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit

class incomeTableViewCell: UITableViewCell {

    //共有インスタンス
//    let incomeAndFIxedTableViewCell = incomeTableViewCell()

    let colors = Colors()

    @IBOutlet weak var incomeSuperCategoryImageButton: UIButton!
    @IBOutlet weak var incomeSuperCategoryNameLabel: UILabel!
    
    @IBOutlet weak var incomeSuperCategoryMoneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = colors.white

        incomeSuperCategoryNameLabel.adjustsFontSizeToFitWidth = true
        incomeSuperCategoryMoneyLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
