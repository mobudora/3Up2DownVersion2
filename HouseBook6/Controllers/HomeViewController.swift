//
//  Home2ViewController.swift
//  HouseBook
//
//  Created by Dora on 2022/03/29.
//

import UIKit
import Firebase
import PKHUD
import GoogleMobileAds

class HomeViewController: UIViewController{

    let yearArray: [String] = ["2022","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033"]
    let monthArray: [String] = ["01","02","03","04","05","06","07","08","09","10","11","12"]

    var bannerView: GADBannerView!

    //インスタンス化
    let db = Firestore.firestore()
    var costMonthSuperCategory: CostMothSuperCategoryFromFireStore?
    let dicForNil: [String:Any] = [:]

    //インスタンス化
    var userDefaults = UserDefaults.standard

    static var homeViewInstance = HomeViewController()

    // 収入と固定費のコレクションの共有インスタンス
    let incomeAndFixedCollectionInstance = incomeAndFixedCostCollectionViewCell.incomeAndFixedCollectionInstance
    var incomeAndFixedIconNameReciever: String!
    var incomeAndFixedIconMoneyReciever: String!
    
    let colors = Colors()

    //カレンダーの日付をとる共有インスタンス
    let calendarViewController = CalendarViewController.calendarViewControllerInstance

    var currentTitleMonth: String!
    var currentTitleYear: String!
    
    @IBAction func goDetailSettingStoryboardButton(_ sender: Any) {
        performSegue(withIdentifier: "goDetailSettingStoryboard", sender: nil)
    }
    
    var sumMoneyButtonFlag: Bool = false
    //総資産と純資産のボタン
    @IBOutlet weak var sumMoneyButton: UIButton!
    @IBAction func changeNetWorth(_ sender: Any) {
        //真偽値を入れ替える。最初はfalseからtrueに変換
        sumMoneyButtonFlag.toggle()
        
        if sumMoneyButtonFlag {
            sumMoneyButton.setTitle("純資産", for: .normal)
        } else {
            sumMoneyButton.setTitle("総資産", for: .normal)
        }
    }
    
    //総資産と純資産の表示箇所
    @IBOutlet weak var sumMoneyBackgroundView: UIView!
    @IBOutlet weak var sumMoneyLabel: UILabel!
    
    //収入と固定費のコレクションビュー
    @IBOutlet weak var incomeAndFixedCostCollection: UICollectionView!
    //収入と固定費のコレクションビューの高さ指定
    @IBOutlet weak var incomeAndFixedCollectionHeightConstraint: NSLayoutConstraint!
    //収入と固定費の数
    let tableCountUp = 3
    //収入と固定費のコレクションビューの題名を入れる配列
    let incomeLabelHeader = ["収入","固定費"]
    
    //生活費のボタン
    @IBOutlet weak var livingExpensesButton: UIButton!
    //生活費の表示箇所
    @IBOutlet weak var livingExpensesBackgroundView: UIView!
    //生活費(収入ー固定費)のテキストラベル
    @IBOutlet weak var livingExpensesTextLabel: UILabel!

    //生活費のコレクションビュー
    
    @IBOutlet weak var livingExpensesCollection: UICollectionView!
    //生活費のコレクションビューの高さ指定
    @IBOutlet weak var livingExpensesCollectionHeightConstraint: NSLayoutConstraint!
    //生活費のコレクションビューの題名を入れる配列
    var livingExpensesLabelHeaderArray: [String] = []
    //生活費の目標金額を格納する配列
    var livingExpensesTargetAmountArray: [String] = []
    //生活費の使用金額を格納する配列
    var livingExpensesUsageAmountArray: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    //生活費目標金額を保存するボタン
    @IBOutlet weak var targetAmountStorageButton: UIButton!
    @IBAction func targetAmountStorageActionButton(_ sender: Any) {
        HUD.show(.progress, onView: view)

        //配列の初期化
        livingExpensesTargetAmountArray = []
        for livingExpensesLabelHeader in livingExpensesLabelHeaderArray {
            switch livingExpensesLabelHeader {
            case "食費":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "foodTargetAmountTextField") ?? "0")
            case "日用品":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "dailyGoodsTargetAmountTextField") ?? "0")
            case "服飾":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "clothTargetAmountTextField") ?? "0")
            case "健康":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "healthTargetAmountTextField") ?? "0")
            case "交際":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "datingTargetAmountTextField") ?? "0")
            case "趣味":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "hobbiesTargetAmountTextField") ?? "0")
            case "教養":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "liberalArtsTargetAmountTextField") ?? "0")
            case "交通":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "transportationTargetAmountTextField") ?? "0")
            case "美容":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "cosmetologyTargetAmountTextField") ?? "0")
            case "観光":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "sightseeingTargetAmountTextField") ?? "0")
            case "車":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "carTargetAmountTextField") ?? "0")
            case "バイク":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "motorcycleTargetAmountTextField") ?? "0")
            case "通信":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "netWorkTargetAmountTextField") ?? "0")
            case "水道代":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "waterTargetAmountTextField") ?? "0")
            case "ガス代":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "gasTargetAmountTextField") ?? "0")
            case "電気代":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "electricityTargetAmountTextField") ?? "0")
            case "保険":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "insuranceTargetAmountTextField") ?? "0")
            case "税金":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "taxTargetAmountTextField") ?? "0")
            case "住宅":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "housingTargetAmountTextField") ?? "0")
            case "医療":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "medicalTargetAmountTextField") ?? "0")
            case "ペット":
                livingExpensesTargetAmountArray.append(userDefaults.string(forKey: "petTargetAmountTextField") ?? "0")
            default:
                break
            }
        }


        livingExpensesCollection.reloadData()
        HUD.hide { (_) in
            HUD.flash(.success, onView: self.view, delay: 1)
        }
    }
    //生活費コレクションを増やすボタン
    @IBOutlet weak var plusLivingExpensesCollectionButton: UIButton!
    @IBAction func plusLivingExpensesCollectionActionButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddCollectionSemiModal", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "AddCollectionViewController") as! AddCollectionViewController
        if let sheet = nextVc.sheetPresentationController {
            //どの位置に止まるのか
            sheet.detents = [.medium()]
        }
        nextVc.delegate = self
        nextVc.costMonthSuperCategory = costMonthSuperCategory
        present(nextVc, animated: true, completion: nil)
    }

    //貯金額のボタン
    @IBOutlet weak var savingAmountButton: UIButton!
    //貯金額の表示箇所
    @IBOutlet weak var savingAmountBackgroundView: UIView!
    //貯金額のテキストラベル
    @IBOutlet weak var savingAmountLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)

        //生活費の使用金額データをFirestoreから読み込む
        getCostMonthSuperCategory()

        //UserDefalutsに保存されている目標金額を読み込む
        livingExpensesTargetAmountArrayAppend()

        //タイトルの日付を取得
        calendarViewController.currentMonth.dateFormat = "MM"
        calendarViewController.currentYear.dateFormat = "yyyy"

        self.navigationItem.setTitleView(withTitle: "\(calendarViewController.currentMonth.string(from: calendarViewController.currentDate))", subTitile: "\(calendarViewController.currentYear.string(from: calendarViewController.currentDate))")

        //収入と固定費の入力の際に何年何月の入力か判断するための変数
        currentTitleYear = calendarViewController.currentYear.string(from: calendarViewController.currentDate)
        currentTitleMonth = calendarViewController.currentMonth.string(from: calendarViewController.currentDate)

        //総資産の背景Viewをセットアップ
        setUpSumMoneyBackgroundContent()
        
        //incomeAndFixedCostのコレクションセルを登録
        incomeAndFixedCostCollection.register(UINib(nibName: "incomeAndFixedCostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "incomeAndFixedCostCell")
        //incomeAndFixedCostCollectionViewの高さを決める(ラベル*2+cell*初期3列+ margin)
        incomeAndFixedCollectionHeightConstraint.constant = CGFloat((44 * 2) + (44 * tableCountUp)) + 20

        //生活費(収入ー固定費)の背景Viewをセットアップ
        setUpLivingExpensesBackgroundContent()
        
        //livingExpensesCollectionのコレクションセルを登録
        livingExpensesCollection.register(UINib(nibName: "livingExpensesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "livingExpensesCustomCell")
        //livingExpensesCollectionViewの高さを決める
        livingExpensesCollectionHeightConstraint.constant = ((UIScreen.main.bounds.width / 2 - 20) * 8 / 2) + 50

        //目標金額保存するボタンのセットアップ
        setUpTargetAmountStorageButton()
        
        //貯金額の背景Viewをセットアップ
        setUpsavingAmountBackgroundContent()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // ???: 場合わけでリロードすることがベストincomeは収入が入力されたときlivingは生活関係が入力されたとき
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let year = calendarViewController.currentYear.string(from: calendarViewController.currentDate)
        
        db.collection("\(year)superCategoryIncomeAndExpenditure").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("使用金額の取得に失敗しました。\(err)")
                return
            } else {
                guard let data = snapshot?.data() else { return }
                self.calendarViewController.currentMonth.dateFormat = "MM"
                let currentMonth = self.calendarViewController.currentMonth.string(from: self.calendarViewController.currentDate)
                //受け取ったユーザー情報の整理
                self.costMonthSuperCategory = CostMothSuperCategoryFromFireStore.init(dic: data, month: currentMonth)
                print("使用金額の取得に成功して代入しました。")

                self.incomeAndFixedCostCollection.reloadData()

            }
        }
    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }

    func getCostMonthSuperCategory() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let year = calendarViewController.currentYear.string(from: calendarViewController.currentDate)

        db.collection("\(year)superCategoryIncomeAndExpenditure").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("使用金額の取得に失敗しました。\(err)")
                return
            } else {
                guard let data = snapshot?.data() else { return }
                self.calendarViewController.currentMonth.dateFormat = "MM"
                let currentMonth = self.calendarViewController.currentMonth.string(from: self.calendarViewController.currentDate)
                //受け取ったユーザー情報の整理
                self.costMonthSuperCategory = CostMothSuperCategoryFromFireStore.init(dic: data, month: currentMonth)
                print("使用金額の取得に成功して代入しました。")

                self.livingExpensesCollection.reloadData()
            }
        }
    }

    func livingExpensesTargetAmountArrayAppend() {
        print("UserDefaluts読み込むよ")

        if let foodTargetAmountTextField = userDefaults.string(forKey: "foodTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(foodTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("食費")
        }
        if let dailyGoodsTargetAmountTextField = userDefaults.string(forKey: "dailyGoodsTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(dailyGoodsTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("日用品")
        }
        if let clothTargetAmountTextField = userDefaults.string(forKey: "clothTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(clothTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("服飾")
        }
        if let healthTargetAmountTextField = userDefaults.string(forKey: "healthTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(healthTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("健康")
        }
        if let datingTargetAmountTextField = userDefaults.string(forKey: "datingTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(datingTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("交際")
        }
        if let hobbiesTargetAmountTextField = userDefaults.string(forKey: "hobbiesTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(hobbiesTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("趣味")
        }
        if let liberalArtsTargetAmountTextField = userDefaults.string(forKey: "liberalArtsTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(liberalArtsTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("教養")
        }
        if let transportationTargetAmountTextField = userDefaults.string(forKey: "transportationTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(transportationTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("交通")
        }
        if let cosmetologyTargetAmountTextField = userDefaults.string(forKey: "cosmetologyTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(cosmetologyTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("美容")
        }
        if let sightseeingTargetAmountTextField = userDefaults.string(forKey: "sightseeingTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(sightseeingTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("観光")
        }
        if let carTargetAmountTextField = userDefaults.string(forKey: "carTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(carTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("車")
        }
        if let motorcycleTargetAmountTextField = userDefaults.string(forKey: "motorcycleTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(motorcycleTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("バイク")
        }
        if let netWorkTargetAmountTextField = userDefaults.string(forKey: "netWorkTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(netWorkTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("通信")
        }
        if let waterTargetAmountTextField = userDefaults.string(forKey: "waterTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(waterTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("水道代")
        }
        if let gasTargetAmountTextField = userDefaults.string(forKey: "gasTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(gasTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("ガス代")
        }
        if let electricityTargetAmountTextField = userDefaults.string(forKey: "electricityTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(electricityTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("電気代")
        }
        if let insuranceTargetAmountTextField = userDefaults.string(forKey: "insuranceTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(insuranceTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("保険")
        }
        if let taxTargetAmountTextField = userDefaults.string(forKey: "taxTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(taxTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("税金")
        }
        if let housingTargetAmountTextField = userDefaults.string(forKey: "housingTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(housingTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("住宅")
        }
        if let medicalTargetAmountTextField = userDefaults.string(forKey: "medicalTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(medicalTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("医療")
        }
        if let petTargetAmountTextField = userDefaults.string(forKey: "petTargetAmountTextField") {
            livingExpensesTargetAmountArray.append(petTargetAmountTextField)
            livingExpensesLabelHeaderArray.append("ペット")
        }
        print("UserDefaluts読み込み終わったよ\(livingExpensesTargetAmountArray)")
    }
    
    func setUpSumMoneyBackgroundContent() {
        sumMoneyBackgroundView.backgroundColor = colors.white
        sumMoneyBackgroundView.layer.cornerRadius = 10
        //shadowOffset = CGSize(width: 大きければ大きほど右に動く, height: 大きければ大きいほど下に動く)
        sumMoneyBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        sumMoneyBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        sumMoneyBackgroundView.layer.shadowOpacity = 0.2
        sumMoneyBackgroundView.layer.borderWidth = 1
        sumMoneyBackgroundView.layer.borderColor = colors.black.cgColor
    }
    
    func setUpLivingExpensesBackgroundContent() {
        livingExpensesBackgroundView.backgroundColor = colors.white
        livingExpensesBackgroundView.layer.cornerRadius = 10
        livingExpensesBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        livingExpensesBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        livingExpensesBackgroundView.layer.shadowOpacity = 0.2
        livingExpensesBackgroundView.layer.borderWidth = 1
        livingExpensesBackgroundView.layer.borderColor = colors.black.cgColor
    }
    
    func setUpsavingAmountBackgroundContent() {
        savingAmountBackgroundView.backgroundColor = colors.white
        savingAmountBackgroundView.layer.cornerRadius = 10
        savingAmountBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        savingAmountBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        savingAmountBackgroundView.layer.shadowOpacity = 0.2
        savingAmountBackgroundView.layer.borderWidth = 1
        savingAmountBackgroundView.layer.borderColor = colors.black.cgColor
    }

    func setUpTargetAmountStorageButton() {
        targetAmountStorageButton.layer.cornerRadius = 10
        targetAmountStorageButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        targetAmountStorageButton.layer.shadowColor = UIColor.gray.cgColor
        targetAmountStorageButton.layer.shadowOpacity = 0.2
        targetAmountStorageButton.layer.borderWidth = 1
        targetAmountStorageButton.layer.borderColor = colors.black.cgColor
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //セクションの数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView.tag == 0 {
            return 1
        } else {
            return 1
        }
    }
    //セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 2
        } else {
            return livingExpensesTargetAmountArray.count
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //収入と固定費のコレクションCell
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "incomeAndFixedCostCell", for: indexPath) as! incomeAndFixedCostCollectionViewCell
            //コレクションビューの題名を入れている配列をラベルに表示
            cell.incomeLabel.text = self.incomeLabelHeader[indexPath.row]
            print("最初のCollectionViewの描画を行います。")
            cell.getIncomeCollectionDataFromFirestore()
            //InputViewControllerへ移動するプロトコル
            cell.delegate = self
            cell.homeLivingExpensesUpdateDelegate = self
            return cell
        } else { //生活費のコレクションCell
            print("生活費のコレクションが読み込まれたよ")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "livingExpensesCustomCell", for: indexPath) as! livingExpensesCollectionViewCell
            //Firestoreからデータを取得した後にもう一回追加するから、初期化
            self.livingExpensesUsageAmountArray.remove(at: indexPath.row)
            //UserDefaultsで取得した目標金額の反映
            cell.targetAmountTextField.text = self.livingExpensesTargetAmountArray[indexPath.row]
            //使用金額の反映
            livingExpensesUsageAmountArray.insert(cell.getUsageAmountFromFireStore(cellTitle: self.livingExpensesLabelHeaderArray[indexPath.row], costMonthSuperCategory: costMonthSuperCategory ?? CostMothSuperCategoryFromFireStore.init(dic: dicForNil, month: ""), index: indexPath.row), at: indexPath.row)
            print("livingExpensesUsageAmountArray: \(livingExpensesUsageAmountArray)")
            cell.usageAmountLabel.text = String(livingExpensesUsageAmountArray[indexPath.row])
            cell.livingExpensesHeaderLabel.text = self.livingExpensesLabelHeaderArray[indexPath.row]
            cell.livingExpensesIconImageView.image = SuperCategoryIcon.CostIcon[livingExpensesLabelHeaderArray[indexPath.row]]
            //貯金額のリロード
            var usageSum = 0
            for usageAmount in livingExpensesUsageAmountArray {
                usageSum += usageAmount
            }
            //生活費
            let intLivingExpensesTextLabel = Int(livingExpensesTextLabel.text ?? "0") ?? 0
            print("生活費金額の合計:\(intLivingExpensesTextLabel)")
            //貯金額
            savingAmountLabel.text = String(intLivingExpensesTextLabel - usageSum)
            print("貯金額の合計:\(savingAmountLabel.text)")
            //総資産への反映
            userDefaults.set(intLivingExpensesTextLabel - usageSum, forKey: "\(currentTitleYear ?? "0")\(currentTitleMonth ?? "0")sumMoney")
            
            for year in yearArray {
                for month in monthArray {
                    sumMoneyLabel.text = String(intLivingExpensesTextLabel - usageSum + userDefaults.integer(forKey: "\(year)\(month)sumMoney"))
                }
            }

            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
//Navigationタイトル変更
extension UINavigationItem {

    func setTitleView(withTitle title: String, subTitile: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 30, weight: .medium)
        titleLabel.textColor = .black

        let subTitleLabel = UILabel()
        subTitleLabel.text = subTitile
        subTitleLabel.font = .systemFont(ofSize: 10)
        subTitleLabel.textColor = .black

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.alignment = .firstBaseline
        stackView.axis = .horizontal

        self.titleView = stackView
    }
}

//HomeViewの収入・固定費テーブルビューからInputViewへ情報が渡されるためのdelegate
extension HomeViewController: PassIncomeAndFixedCollectionCellProtocol {

    func goInputViewController(h1Label: String) {
        let storyboard = UIStoryboard(name: "Input", bundle: nil)
        // ここに画面遷移処理(NextViewControllerに遷移する処理)を記載
        let nextVc = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        nextVc.incomeAndFixedCellReciever = h1Label
        if h1Label == "固定費名" {
            //Firestoreへ保存する固定費と他を区別するための名前
            nextVc.fixedCostReciever = "固定費"
        } else if h1Label == "収入名" {
            nextVc.incomeReciever = "収入"
        }
        nextVc.calendarYearReciver = currentTitleYear
        nextVc.calendarMonthReciver = currentTitleMonth
        //遷移先がpageshhetでもdismiss時にviewwillApeearが呼ばれるようにする
        nextVc.presentationController?.delegate = self
        self.present(nextVc, animated: true)
    }
}
//戻ったときに通知される処理
extension HomeViewController: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // Modal画面から戻った際の画面の更新処理を行う。収入か固定費のプラスをクリックして戻るとき
        print("戻ってリロードするよ")
        self.incomeAndFixedCostCollection.reloadData()
    }
}
//生活費(収入ー固定費)を更新するためのプロトコル
extension HomeViewController: IncomeAndFixedToHomeProtocol {

    func livingExpensesLabelUpdate(incomeSumText: String, fixedCostSumText: String) {
        //生活費(収入ー固定費)のテキストを表示
        // ???: Intに変換して代入しないとうまくいかない
        let intIncomeSumText = Int(incomeSumText) ?? 0
        let intFixedCostSumText = Int(fixedCostSumText) ?? 0
        print("intIncomeSumText: \(intIncomeSumText)")
        print("intFixedCostSumText: \(intFixedCostSumText)")
        livingExpensesTextLabel.text = String(intIncomeSumText - intFixedCostSumText)
        print("livingExpensesTextLabel.text: \(livingExpensesTextLabel.text)")
        //収入と固定費のFirestoreからの読み取りが終わり次第反映のためのリロード
        livingExpensesCollection.reloadData()
    }
}
//コレクションセルを追加するプロトコル
extension HomeViewController: AddCollectionViewCellProtocol {
    func addCollectionViewCell(collectionTitle: String, collectionImage: UIImage, collectionUsageAmount: Int) {
        livingExpensesLabelHeaderArray.append(collectionTitle)
        livingExpensesTargetAmountArray.append("0")
        livingExpensesUsageAmountArray.append(collectionUsageAmount)
        livingExpensesCollection.reloadData()
    }
}
