//
//  incomePlusMinusTableViewCell.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit

class incomePlusMinusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var incomeTableViewCellPlusButton: UIButton!
    @IBAction func incomeTableViewCellPlusActionButton(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        incomeTableViewCellPlusButton.setImage(UIImage(systemName: "plus.square"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

