//
//  dateDiaryCollectionViewCell.swift
//  HouseBook6
//
//  Created by Ryu on 2022/04/22.
//

import UIKit

class dateDiaryCollectionViewCell: UICollectionViewCell {

    //contentCellのSuperCategoryNameを受け取る変数
    var recieveSuperCategoryName: [String]?
    var recieveSubCategoryName: [[String]]?
    var recieveSubMoney: [[Int]]?
    var recieveSubCategoryArray: [String]?

    //日付を受け取る変数
    var recieveCellDay: Int!

    //delegateを受け取る変数
    var recieveDelegate: CalendarViewController?

    //コレクションの日にちを受け取る変数
    var currentCellDay: String!
    //コレクションの月を受け取る変数
    var currentCellMonth: String!

    var countUpForTableView = 0

    //カテゴリーの数
    var categoryCount: Int = 1
    
    @IBOutlet weak var tableH1Label: UILabel!
    @IBOutlet weak var tableH2HorizontalStackView: UIStackView!

    @IBOutlet weak var dateCategoryCollectionView: UICollectionView!
    //その日の合計
    @IBOutlet weak var dateCostSumAmountButton: UIButton!
    @IBAction func dateCostSUmAmountButtonAction(_ sender: Any) {
        var sumSubCategoryMoney: [Int] = []
        for subCategoryMoney in recieveSubMoney ?? [[0]] {
            sumSubCategoryMoney.append(subCategoryMoney.reduce(0, +))
        }
        let sumSubCategoryMoneyPerDay = sumSubCategoryMoney.reduce(0, +)
        dateCostSumAmountLabel.text = String(sumSubCategoryMoneyPerDay)
    }
    @IBOutlet weak var dateCostSumAmountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        dateCategoryCollectionView.delegate = self
        dateCategoryCollectionView.dataSource = self

        dateCategoryCollectionView.register(UINib(nibName: "DateContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DateContentCell")
        
    }

}

extension dateDiaryCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //ここでカテゴリーの入力が増えたらコレクションを増やす(大元のコレクション)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //ここでカテゴリーの数が増えたら数値を増やす
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dateCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "DateContentCell", for: indexPath) as! DateContentCollectionViewCell
        cell.recieveIndexPath = indexPath.row
        //日毎の親カテゴリーNameを渡す
        cell.recieveSuperCategoryNamePerDay = recieveSuperCategoryName
        cell.recieveSubCategoryNamePerDay = recieveSubCategoryName
        cell.recieveSubMoneyPerDay = recieveSubMoney
        cell.recieveCellDay = recieveCellDay
        //tablevoewの個数を渡す
        cell.recieveSubCategoryArray = recieveSubCategoryArray
        //月を渡す
        cell.currentCellMonth = currentCellMonth
        var sumSubCategoryMoney: [Int] = []
        for subCategoryMoney in recieveSubMoney ?? [[0]] {
            sumSubCategoryMoney.append(subCategoryMoney.reduce(0, +))
        }
        let sumSubCategoryMoneyPerDay = sumSubCategoryMoney.reduce(0, +)
        dateCostSumAmountLabel.text = String(sumSubCategoryMoneyPerDay)
        print("リロードするよ")
        cell.dateContentTableView.reloadData()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellMaxHeight: CGFloat = 32 * 4
        let cellCount: CGFloat = 1
        let cellMargin: CGFloat = 10
        let cellMarginCount: CGFloat = cellCount

        return CGSize(width: dateCategoryCollectionView.bounds.width, height: cellMaxHeight * cellCount + cellMargin * cellMarginCount)
    }
}
