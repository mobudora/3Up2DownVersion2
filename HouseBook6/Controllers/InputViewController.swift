//
//  InputViewController.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/06.
//

import UIKit
import Firebase
import FirebaseFirestore
import PKHUD


class InputViewController: UIViewController {

    //固定費から来たか判断する変数Firestoreへ保存する
    var fixedCostReciever: String!
    //収入からきたか判断する変数
    var incomeReciever: String!

    //共有用のインスタンス(どこからでも参照できる)
    static var inputViewControllerInstance = InputViewController()

    let homeViewInstance = HomeViewController.homeViewInstance

    //支出サブカテゴリーのどれを表示するか決めるために受け取る変数
    var costCategoryIndex: Int!
    //収入サブカテゴリーのどれを表示するか決めるために受け取る変数
    var incomeCategoryIndex: Int!
    //どちらから遷移してきたか判断する変数
    var whichIsTheTransition = ""

    //収入コレクションか固定費コレクションか判断するための変数("収入名"か"固定費名"が受け渡される)
    var incomeAndFixedCellReciever: String!
    
    var calendarYearReciver = ""
    var calendarMonthReciver = ""
    var calendarDayReciver = ""
    
    //カレンダーラベル
    let inputCalendarDate = InputLabel()
    
    var inputMoneyNumbers = InputButton(title: "0")
    
    var inputSuperCategoryIcon = InputButton(image: UIImage(systemName: "questionmark") ?? UIImage())
    
    var inputSuperCategoryTitle = InputLabel(title: "未分類")
    
    var inputSubCategoryIcon = InputButton(image: UIImage(systemName: "greaterthan") ?? UIImage())
    
    var inputSubCategoryTitle = InputLabel(title: "未分類")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //カレンダーラベル
        inputCalendarDate.text = "\(calendarYearReciver)年\(calendarMonthReciver)月"
        //カレンダーから来たときは何も渡してないからincomeAndFixedCellRecieverがnilになってifの中に入る
        if !(incomeAndFixedCellReciever == "収入名" || incomeAndFixedCellReciever == "固定費名" || incomeAndFixedCellReciever == "") {
            inputCalendarDate.text = "\(calendarYearReciver)年\(calendarMonthReciver)/\(calendarDayReciver)"
        }

        inputCalendarDate.textAlignment = .center
        view.addSubview(inputCalendarDate)
        
        //入力するお金ボタン
        inputMoneyNumbers.addTarget(self, action: #selector(goInputCalculatorSemiModal), for: .touchUpInside)
        inputMoneyNumbers.layer.shadowOffset = CGSize(width: 2, height: 2)
        inputMoneyNumbers.layer.shadowColor = UIColor.gray.cgColor
        inputMoneyNumbers.layer.shadowOpacity = 0.5
        view.addSubview(inputMoneyNumbers)
        print("お金何円\(inputMoneyNumbers.titleLabel?.text ?? String())")
        
        //収入、支出の親アイコン
        inputSuperCategoryIcon.layer.cornerRadius = UIScreen.main.bounds.width / 16
        inputSuperCategoryIcon.addTarget(self, action: #selector(goInputCategorySemiModal), for: .touchUpInside)
        view.addSubview(inputSuperCategoryIcon)
        
        inputSuperCategoryTitle.textAlignment = .center
        view.addSubview(inputSuperCategoryTitle)
        
        inputSubCategoryIcon.layer.cornerRadius = UIScreen.main.bounds.width / 16
        inputSubCategoryIcon.addTarget(self, action: #selector(goInputSubCategorySemiModal), for: .touchUpInside)
        view.addSubview(inputSubCategoryIcon)
        
        inputSubCategoryTitle.textAlignment = .center
        view.addSubview(inputSubCategoryTitle)
        
        let resulutButton = InputButton(title: "保存")
        resulutButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        resulutButton.addTarget(self, action: #selector(saveToFirebase), for: .touchUpInside)
        view.addSubview(resulutButton)
        
        
        inputCalendarDate.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 80)
        inputMoneyNumbers.anchor(top: inputCalendarDate.bottomAnchor, left: view.leftAnchor,  right: view.rightAnchor,height: 120)
        inputSuperCategoryIcon.anchor(top: inputMoneyNumbers.bottomAnchor, left: view.leftAnchor, width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.width / 8, topPadding: UIScreen.main.bounds.width / 16, leftPadding: UIScreen.main.bounds.width / 16)
        inputSuperCategoryTitle.anchor(top: inputMoneyNumbers.bottomAnchor, left: inputSuperCategoryIcon.rightAnchor, width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4, leftPadding: UIScreen.main.bounds.width / 16)
        inputSubCategoryIcon.anchor(top: inputMoneyNumbers.bottomAnchor, left: inputSuperCategoryTitle.rightAnchor, width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.width / 8, topPadding: UIScreen.main.bounds.width / 16, leftPadding: UIScreen.main.bounds.width / 16)
        inputSubCategoryTitle.anchor(top: inputMoneyNumbers.bottomAnchor, left: inputSubCategoryIcon.rightAnchor, width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4, leftPadding: UIScreen.main.bounds.width / 16)
        resulutButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 60)
        
    }

    //電卓画面へ
    @objc func goInputCalculatorSemiModal() {
        let storyboard = UIStoryboard(name: "InputCalculatorSemiModal", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InputCalculatorSemiModalViewController") as! InputCalculatorSemiModalViewController
        if let sheet = vc.sheetPresentationController {
            //どの位置に止まるのか
            sheet.detents = [.medium()]
        }
        //電卓の数値をInputViewController==selfに適応する
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

    //カテゴリーを選択する画面に飛ぶ
    @objc func goInputCategorySemiModal() {
        let storyboard = UIStoryboard(name: "InputCategorySemiModal", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "InputCategorySemiModalViewController") as! InputCategorySemiModalViewController
        if let sheet = nextVc.sheetPresentationController {
            //どの位置に止まるのか
            sheet.detents = [.medium()]
        }
        //カテゴリーの画像とタイトルをInputViewController==selfに適応する
        nextVc.delegate = self
        if incomeAndFixedCellReciever == "収入名" {
            nextVc.recieveWhitchIsCollectionCell = 1
        }
        present(nextVc, animated: true, completion: nil)
    }

    //サブカテゴリーの選択画面にいく
    @objc func goInputSubCategorySemiModal() {
        let storyboard = UIStoryboard(name: "InputSubCategorySemiModal", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "InputSubCategorySemiModalViewController") as! InputSubCategorySemiModalViewController
        if let sheet = nextVc.sheetPresentationController {
            //どの位置に止まるのか
            sheet.detents = [.medium()]
        }
        InputViewController.inputViewControllerInstance.whichIsTheTransition = "InputViewから来たよ"
        present(nextVc, animated: true, completion: nil)
    }
    
    @objc func saveToFirebase() {
        
        HUD.show(.progress, onView: view)
        //最初に今ログインしているユーザーの情報を取得する
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let year = "\(self.calendarYearReciver)"

        var month = "\(self.calendarMonthReciver)"

        //Firestoreへ保存する際に0をつけないと綺麗に並ばない
        switch self.calendarMonthReciver {
        case "1":
            month = "0\(self.calendarMonthReciver)"
        case "2":
            month = "0\(self.calendarMonthReciver)"
        case "3":
            month = "0\(self.calendarMonthReciver)"
        case "4":
            month = "0\(self.calendarMonthReciver)"
        case "5":
            month = "0\(self.calendarMonthReciver)"
        case "6":
            month = "0\(self.calendarMonthReciver)"
        case "7":
            month = "0\(self.calendarMonthReciver)"
        case "8":
            month = "0\(self.calendarMonthReciver)"
        case "9":
            month = "0\(self.calendarMonthReciver)"
        default:
            break
        }

        let day = "\(self.calendarDayReciver)"
        
        let inputMoney = inputMoneyNumbers.titleLabel?.text ?? String()
        
        let superCategoryName = "\(inputSuperCategoryTitle.text ?? String())"
        
        let subCategoryName = "\(inputSubCategoryTitle.text ?? String())"
        
        let dayId = randomString(length: 10)

        homeViewInstance.incomeAndFixedIconNameReciever = inputSuperCategoryTitle.text
        homeViewInstance.incomeAndFixedIconMoneyReciever = inputMoneyNumbers.titleLabel?.text
        print("渡す変数\(homeViewInstance.incomeAndFixedIconNameReciever)")

        let nib = UINib(nibName: "incomeTableViewCell", bundle: Bundle(for: type(of: self)))
        let cell = nib.instantiate(withOwner: self, options: nil).first as! incomeTableViewCell
        cell.incomeSuperCategoryNameLabel.text = inputSuperCategoryTitle.text
        cell.incomeSuperCategoryMoneyLabel.text = inputMoneyNumbers.titleLabel?.text

        //Firestoreへyear親カテゴリーコレクションとドキュメントにサブカテゴリーを配置。monthサブカテゴリーSumMoneyフィールドをupDateしていく
        updateFirestoreYearSubCategoryCollection(uid: uid, day: day, year: year, month: month, subCategoryName: subCategoryName, superCategoryName: superCategoryName, inputMoney: inputMoney, dayId: dayId)
        
        //Firestoreのcostコレクションのuidドキュメントにmonth親カテゴリーSumMoneyフィールドと、year親カテゴリーSumMoneyフィールドをアップデートしていく
        updateFirestoreYearSuperCategoryCollection(uid: uid, month: month, year: year, superCategoryName: superCategoryName, subCategoryName: subCategoryName, inputMoney: inputMoney)
        
        print("親カテゴリー\(inputSuperCategoryTitle.text ?? String())")
        print("サブカテゴリー\(inputSubCategoryTitle.text ?? String())")
        print("お金何円\(inputMoneyNumbers.titleLabel?.text ?? String())の保存に成功しました。")

    }
    
    //Firestoreへサブカテゴリーの支出と収入を保存していく
    func updateFirestoreYearSubCategoryCollection(uid: String, day: String, year: String, month: String, subCategoryName: String, superCategoryName: String, inputMoney: String, dayId: String) {
        //nilチェックしてfixedCostRecieverをoptional型でデータを保存しないようにする
        if let fixedCostReciever = fixedCostReciever {
            //固定費サブカテゴリーSumMoneyだけを増加
            Firestore.firestore().collection("\(year)subCategoryIncomeAndExpenditure").document(uid).updateData ([

                "\(month)\(subCategoryName)\(fixedCostReciever)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(year)\(subCategoryName)\(fixedCostReciever)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64())

            ]){ err in
                if let err = err {
                    print("Firestoreへの固定費サブカテゴリーフィールド情報の更新に失敗しました。\(err)")
                    self.saveFirestoreYearSubCategoryCollection(uid: uid,  day: day, year: year, month: month, subCategoryName: subCategoryName, superCategoryName: superCategoryName, inputMoney: inputMoney, dayId: dayId)
                } else {
                    print("Firestoreへの固定費サブカテゴリーフィールド情報の更新に成功しました。")
                }
            }
        } else if incomeReciever != nil {
            //収入サブカテゴリーSumMoneyだけを増加
            Firestore.firestore().collection("\(year)subCategoryIncomeAndExpenditure").document(uid).updateData ([

                "\(month)\(subCategoryName)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(year)\(subCategoryName)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64())

            ]){ err in
                if let err = err {
                    print("Firestoreへの収入サブカテゴリーフィールド情報の更新に失敗しました。\(err)")
                    self.saveFirestoreYearSubCategoryCollection(uid: uid,  day: day, year: year, month: month, subCategoryName: subCategoryName, superCategoryName: superCategoryName, inputMoney: inputMoney, dayId: dayId)
                } else {
                    print("Firestoreへの収入サブカテゴリーフィールド情報の更新に成功しました。")
                }
            }
        } else {
            //初回だけyear親カテゴリーコレクションをセットアップする
            Firestore.firestore().collection("\(year)subCategoryIncomeAndExpenditure").document(uid).updateData ([

                "\(month)\(day)\(subCategoryName)\(dayId)": Int(inputMoney) ?? 0,
                "\(month)\(day)\(subCategoryName)dayId配列": FieldValue.arrayUnion([dayId]),
                "\(month)\(day)\(subCategoryName)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(month)\(day)\(superCategoryName)配列": FieldValue.arrayUnion([subCategoryName]),
                "\(month)\(day)カテゴリー配列": FieldValue.arrayUnion([superCategoryName]),
                "\(month)\(subCategoryName)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(year)\(subCategoryName)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(month)\(superCategoryName)配列": FieldValue.arrayUnion([subCategoryName]),
                "\(month)Day配列": FieldValue.arrayUnion([day])

            ]){ err in
                if let err = err {
                    print("Firestoreへのサブカテゴリーフィールド情報の更新に失敗しました。\(err)")
                    self.saveFirestoreYearSubCategoryCollection(uid: uid,  day: day, year: year, month: month, subCategoryName: subCategoryName, superCategoryName: superCategoryName, inputMoney: inputMoney, dayId: dayId)
                } else {
                    print("Firestoreへのサブカテゴリーフィールド情報の更新に成功しました。")
                }
            }
        }
    }
    
    func saveFirestoreYearSubCategoryCollection(uid: String, day: String, year: String, month: String, subCategoryName: String, superCategoryName: String, inputMoney: String, dayId: String) {

        if let fixedCostReciever = fixedCostReciever {

            // ???: 最初に保存するときにデータを最低1個保存するのは後にUpdateするため二重に保存してしまう
            let yearSuperCategoryData = [

                "\(month)\(subCategoryName)\(fixedCostReciever)SumMoney": inputMoney

            ] as [String: Any]

            //選択した年をFirestoreのyear親カテゴリーコレクションを作成セットアップする。
            Firestore.firestore().collection("\(year)subCategoryIncomeAndExpenditure").document(uid).setData(yearSuperCategoryData) { err in
                if let err = err {
                    print("Firestoreの固定費サブカテゴリードキュメント作成に失敗しました。: \(err)")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                } else {
                    print("Firestoreの固定費サブカテゴリードキュメント作成に成功しました。")
                    self.updateFirestoreYearSubCategoryCollection(uid: uid,  day: day, year: year, month: month, subCategoryName: subCategoryName, superCategoryName: superCategoryName, inputMoney: inputMoney, dayId: dayId)
                }
            }
        } else {
            //収入からきても支出からきても同じデータを保存するからelseでまとめられる
            let yearSuperCategoryData = [

                "\(month)\(subCategoryName)SumMoney": inputMoney

            ] as [String: Any]

            //選択した年をFirestoreのyear親カテゴリーコレクションを作成セットアップする。
            Firestore.firestore().collection("\(year)subCategoryIncomeAndExpenditure").document(uid).setData(yearSuperCategoryData) { err in
                if let err = err {
                    print("Firestoreのサブカテゴリードキュメント作成に失敗しました。: \(err)")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                } else {
                    print("Firestoreのサブカテゴリードキュメント作成に成功しました。")
                    self.updateFirestoreYearSubCategoryCollection(uid: uid,  day: day, year: year, month: month, subCategoryName: subCategoryName, superCategoryName: superCategoryName, inputMoney: inputMoney, dayId: dayId)
                }
            }
        }
    }
    
    //Firestoreに親カテゴリーの収入と支出合計値を保存する
    func updateFirestoreYearSuperCategoryCollection(uid: String, month: String, year: String, superCategoryName: String, subCategoryName: String, inputMoney: String) {
        //nilチェックしてfixedCostRecieverをoptional型でデータを保存しないようにする
        if let fixedCostReciever = fixedCostReciever {
            Firestore.firestore().collection("\(year)superCategoryIncomeAndExpenditure").document(uid).updateData([

                "\(year)\(superCategoryName)\(fixedCostReciever)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(month)\(superCategoryName)\(fixedCostReciever)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(month)\(superCategoryName)\(fixedCostReciever)配列": FieldValue.arrayUnion([subCategoryName])

            ]){ err in
                if let err = err {
                    print("Firestoreへの親カテゴリー情報の更新に失敗しました。\(err)")
                } else {
                    print("Firestoreへの親カテゴリー情報の更新に成功しました。")
                    HUD.hide { (_) in
                        HUD.flash(.success, onView: self.view, delay: 1) { (_) in
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        } else {
            Firestore.firestore().collection("\(year)superCategoryIncomeAndExpenditure").document(uid).updateData([

                "\(year)\(superCategoryName)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(month)\(superCategoryName)SumMoney": FieldValue.increment(Int64(inputMoney) ?? Int64()),
                "\(month)\(superCategoryName)配列": FieldValue.arrayUnion([subCategoryName])

            ]){ err in
                if let err = err {
                    print("Firestoreへの親カテゴリー情報の更新に失敗しました。\(err)")
                } else {
                    print("Firestoreへの親カテゴリー情報の更新に成功しました。")
                    HUD.hide { (_) in
                        HUD.flash(.success, onView: self.view, delay: 1) { (_) in
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }

    func saveFirestoreYearSuperCategoryCollection(uid: String, day: String, year: String, month: String, subCategoryName: String, superCategoryName: String, inputMoney: String, dayId: String) {

        if let fixedCostReciever = fixedCostReciever {

            // ???: 最初に保存するときにデータを最低1個保存するのは後にUpdateするため二重に保存してしまう
            let yearSuperCategoryData = [

                "\(year)\(superCategoryName)\(fixedCostReciever)SumMoney": inputMoney

            ] as [String: Any]

            //選択した年をFirestoreのyear親カテゴリーコレクションを作成セットアップする。
            Firestore.firestore().collection("\(year)subCategoryIncomeAndExpenditure").document(uid).setData(yearSuperCategoryData) { err in
                if let err = err {
                    print("Firestoreの親カテゴリードキュメント作成に失敗しました。: \(err)")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                } else {
                    print("Firestoreの親カテゴリードキュメント作成に成功しました。")
                    self.updateFirestoreYearSuperCategoryCollection(uid: uid, month: month, year: year, superCategoryName: superCategoryName, subCategoryName: subCategoryName, inputMoney: inputMoney)
                }
            }
        } else {
            //収入からきても支出からきても同じデータを保存するからelseでまとめられる
            let yearSuperCategoryData = [

                "\(year)\(superCategoryName)SumMoney": inputMoney

            ] as [String: Any]

            //選択した年をFirestoreのyear親カテゴリーコレクションを作成セットアップする。
            Firestore.firestore().collection("\(year)subCategoryIncomeAndExpenditure").document(uid).setData(yearSuperCategoryData) { err in
                if let err = err {
                    print("Firestoreの親カテゴリードキュメント作成に失敗しました。: \(err)")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                } else {
                    print("Firestoreの親カテゴリードキュメント作成に成功しました。")
                    self.updateFirestoreYearSuperCategoryCollection(uid: uid, month: month, year: year, superCategoryName: superCategoryName, subCategoryName: subCategoryName, inputMoney: inputMoney)
                }
            }
        }

    }
    
    func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
}
//電卓の数字を渡されるプロトコル
extension InputViewController: PassCaluculatorProtocol {
    func recieveData(data: String) {
        inputMoneyNumbers.setTitle("\(data)", for: .normal)
    }
}
//収入、支出のカテゴリーを渡されるプロトコル
extension InputViewController: PassCategoryProtocol {
    func recieveSuperCategoryData(superImage: UIImage,superTitle: String) {
        inputSuperCategoryIcon.setImage(superImage, for: .normal)
        inputSuperCategoryTitle.text = "\(superTitle)"
    }
}
extension InputViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
