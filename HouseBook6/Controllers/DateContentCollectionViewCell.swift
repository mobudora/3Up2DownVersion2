//
//  DateContentCollectionViewCell.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/23.
//

import UIKit
import Firebase

class DateContentCollectionViewCell: UICollectionViewCell {

    //日毎のSuperCategoryNameを受け取る変数
    var recieveSuperCategoryNamePerDay: [String]?
    var recieveSubCategoryNamePerDay: [[String]]?
    var recieveSubMoneyPerDay: [[Int]]?
    var recieveSubCategoryArray: [String]?

    //日付を受け取る変数
    var recieveCellDay: Int!

    //コレクションCellから月を受け取る変数
    var currentCellMonth: String!

    //親のコレクションCellのindexPathを受け取る変数
    var recieveIndexPath: Int!

    //インスタンス化
    var userDefaults = UserDefaults.standard
    

    @IBOutlet weak var dateContentTableView: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateContentTableView.delegate = self
        dateContentTableView.dataSource = self
        //アイコンと合計金額のCellを登録
        dateContentTableView.register(UINib(nibName: "DateCategoryAndSumMoneyTableViewCell", bundle: nil), forCellReuseIdentifier: "sumCategoryCell")
        //サブカテゴリー名前と金額のCellを登録
        dateContentTableView.register(UINib(nibName: "CategoryMoneyTableViewCell", bundle: nil), forCellReuseIdentifier: "cotegoryMoneyCell")
    }
}
extension DateContentCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セクションを2つ作って2つの異なるxibファイルを表示する
        if section == 0 {
            return 1
        } else {
            print("recieveSubCategoryNamePerDay:\(recieveSubCategoryNamePerDay)")
            //予めサブカテゴリー名前をコレクションViewControllerの数と合わせているため、親のコレクションViewControllerの数をrecieveIndexPathで表している
            return recieveSubCategoryNamePerDay?[recieveIndexPath].count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            print("イメージ合計更新します")
            let cell = tableView.dequeueReusableCell(withIdentifier: "sumCategoryCell", for: indexPath) as! DateCategoryAndSumMoneyTableViewCell
            if self.recieveSuperCategoryNamePerDay == [] {
                cell.sumCategoryImageView.image = UIImage(systemName: "questionmark.square")
            } else {
                print("recieveSuperCategoryNamePerDay: \(recieveSuperCategoryNamePerDay)")
                cell.sumCategoryImageView.image = SuperCategoryIcon.CostIcon[(self.recieveSuperCategoryNamePerDay?[recieveIndexPath])!] ?? UIImage(systemName: "questionmark.square")
            }
            guard let sumSubMoney = recieveSubMoneyPerDay?[recieveIndexPath].reduce(0, +) else { return cell }
            cell.sumMoneyLabel.text = String(sumSubMoney)
            return cell
        default:
            print("カテゴリー内更新します")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cotegoryMoneyCell", for: indexPath) as! CategoryMoneyTableViewCell
            print("recieveSubCategoryNamePerDay:\(recieveSubCategoryNamePerDay)")
            cell.subCategoryNameLabel.text = recieveSubCategoryNamePerDay?[recieveIndexPath][indexPath.row]
            print("recieveSubMoneyPerDay:\(recieveSubMoneyPerDay)")
            guard let stringSubMoney = recieveSubMoneyPerDay?[recieveIndexPath][indexPath.row] else { return cell }
            cell.subCategoryMoneyLabel.text = String(stringSubMoney)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}
