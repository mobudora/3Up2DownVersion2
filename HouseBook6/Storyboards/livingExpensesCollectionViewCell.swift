//
//  livingExpensesCollectionViewCell.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit
import Firebase

class livingExpensesCollectionViewCell: UICollectionViewCell {

    var recieveLivingExpensesUsageAmount: Int?

    let calendarViewController = CalendarViewController.calendarViewControllerInstance

    //FirestoreDBのインスタンス化
    let db = Firestore.firestore()

    //UserDefaultsのインスタンス化
    var userDefaults = UserDefaults.standard

    let colors = Colors()
    
    //生活費のヘッダー
    @IBOutlet weak var livingExpensesHeaderLabel: UILabel!
    
    //生活費のアイコン
    @IBOutlet weak var livingExpensesIconImageView: UIImageView!
    
    //目標金額
    @IBOutlet weak var targetAmountTextField: UITextField!

    @IBAction func targetAmountActionTextField(_ sender: Any) {
        print("書き込まれたよ:\(targetAmountTextField.text)")
        switch livingExpensesHeaderLabel.text {
        case "食費":
            userDefaults.set(targetAmountTextField.text, forKey: "foodTargetAmountTextField")
        case "日用品":
            userDefaults.set(targetAmountTextField.text, forKey: "dailyGoodsTargetAmountTextField")
        case "服飾":
            userDefaults.set(targetAmountTextField.text, forKey: "clothTargetAmountTextField")
        case "健康":
            userDefaults.set(targetAmountTextField.text, forKey: "healthTargetAmountTextField")
        case "交際":
            userDefaults.set(targetAmountTextField.text, forKey: "datingTargetAmountTextField")
        case "趣味":
            userDefaults.set(targetAmountTextField.text, forKey: "hobbiesTargetAmountTextField")
        case "教養":
            userDefaults.set(targetAmountTextField.text, forKey: "liberalArtsTargetAmountTextField")
        case "交通":
            userDefaults.set(targetAmountTextField.text, forKey: "transportationTargetAmountTextField")
        case "美容":
            userDefaults.set(targetAmountTextField.text, forKey: "cosmetologyTargetAmountTextField")
        case "観光":
            userDefaults.set(targetAmountTextField.text, forKey: "sightseeingTargetAmountTextField")
        case "車":
            userDefaults.set(targetAmountTextField.text, forKey: "carTargetAmountTextField")
        case "バイク":
            userDefaults.set(targetAmountTextField.text, forKey: "motorcycleTargetAmountTextField")
        case "通信":
            userDefaults.set(targetAmountTextField.text, forKey: "netWorkTargetAmountTextField")
        case "水道代":
            userDefaults.set(targetAmountTextField.text, forKey: "waterTargetAmountTextField")
        case "ガス代":
            userDefaults.set(targetAmountTextField.text, forKey: "gasTargetAmountTextField")
        case "電気代":
            userDefaults.set(targetAmountTextField.text, forKey: "electricityTargetAmountTextField")
        case "保険":
            userDefaults.set(targetAmountTextField.text, forKey: "insuranceTargetAmountTextField")
        case "税金":
            userDefaults.set(targetAmountTextField.text, forKey: "taxTargetAmountTextField")
        case "住宅":
            userDefaults.set(targetAmountTextField.text, forKey: "housingTargetAmountTextField")
        case "医療":
            userDefaults.set(targetAmountTextField.text, forKey: "medicalTargetAmountTextField")
        case "ペット":
            userDefaults.set(targetAmountTextField.text, forKey: "petTargetAmountTextField")
        case .none:
            break
        case .some(_):
            break
        }
    }

    //使用済み金額
    @IBOutlet weak var usageAmountLabel: UILabel!
    //残高ラベル
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("使用金額が読み込まれるよ")
        //コレクションビューのデザイン
        baseCollectionViewSetUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    //一番大元となるcollectionviewのデザイン
    func baseCollectionViewSetUp() {
        backgroundColor = colors.white
        layer.cornerRadius = 10
        //shadowOffset = CGSize(width: 大きければ大きほど右に動く, height: 大きければ大きいほど下に動く)
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.borderWidth = 1
        layer.borderColor = colors.black.cgColor
        self.anchor(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.width / 2 - 20)
    }
    
    //Collectionが更新されるときに毎回呼ばれる
    func getUsageAmountFromFireStore(cellTitle: String, costMonthSuperCategory: CostMothSuperCategoryFromFireStore, index: Int) -> Int {
        print("costMonthSuperCategory: \(costMonthSuperCategory)")
        //使用金額にFirestoreからの情報を代入する
        switch cellTitle {
        case "食費":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.foodMonthSuperCategoryFromFirestore ?? 0
        case "日用品":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.dailyGoodsMonthSuperCategoryFromFirestore ?? 0
        case "服飾":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.clothMonthSuperCategoryFromFirestore ?? 0
        case "健康":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.healthdMonthSuperCategoryFromFirestore ?? 0
        case "交際":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.datingMonthSuperCategoryFromFirestore ?? 0
        case "趣味":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.hobbiesMonthSuperCategoryFromFirestore ?? 0
        case "教養":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.liberalArtsMonthSuperCategoryFromFirestore ?? 0
        case "交通":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.transportationMonthSuperCategoryFromFirestore ?? 0
        case "美容":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.cosmetologyMonthSuperCategoryFromFirestore ?? 0
        case "観光":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.sightseeingMonthSuperCategoryFromFirestore ?? 0
        case "車":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.carMonthSuperCategoryFromFirestore ?? 0
        case "バイク":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.motorcycleMonthSuperCategoryFromFirestore ?? 0
        case "通信":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.netWorkMonthSuperCategoryFromFirestore ?? 0
        case "水道代":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.waterMonthSuperCategoryFromFirestore ?? 0
        case "ガス代":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.gasMonthSuperCategoryFromFirestore ?? 0
        case "電気代":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.electricityMonthSuperCategoryFromFirestore ?? 0
        case "保険":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.insuranceMonthSuperCategoryFromFirestore ?? 0
        case "税金":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.taxMonthSuperCategoryFromFirestore ?? 0
        case "住宅":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.housingMonthSuperCategoryFromFirestore ?? 0
        case "医療":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.medicalMonthSuperCategoryFromFirestore ?? 0
        case "ペット":
            self.recieveLivingExpensesUsageAmount = costMonthSuperCategory.petMonthSuperCategoryFromFirestore ?? 0
        default:
            break
        }
        print("使用金額の取得に成功しました。")
        //ここ(targetAmountTextField)はUserDefaultsから読み込まれているから値はある
        guard let intTargetAmountLabel = Int(self.targetAmountTextField.text ?? "0") else { return recieveLivingExpensesUsageAmount ?? 0 }

        let intUsageAmountLabel = Int(self.recieveLivingExpensesUsageAmount ?? 0)
        
        self.balanceLabel.text = String(intTargetAmountLabel - intUsageAmountLabel)
        print("残高のおかねは何円？:\(self.balanceLabel.text)")
        return recieveLivingExpensesUsageAmount ?? 0
    }
    
}
