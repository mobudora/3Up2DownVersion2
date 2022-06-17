//
//  DateCategoryAndSumMoneyTableViewCell.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/23.
//

import UIKit

class DateCategoryAndSumMoneyTableViewCell: UITableViewCell {

    @IBOutlet weak var sumCategoryImageView: UIImageView!
    @IBOutlet weak var sumMoneyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sumMoneyLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
