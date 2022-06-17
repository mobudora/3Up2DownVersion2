//
//  CalendarViewController.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import Firebase

class CalendarViewController: UIViewController {
    
    //データベースのインスタンス化
    let db = Firestore.firestore()
    
    var costMonthSuperCategoryArray: [String] = []
    //親カテゴリーアイコンImageを月と日付毎に持っておく
    var allDaySuperCategoryName: [[[String]]] = [[[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                 [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
    ]
    //日付毎に要素番号と関連してデータを持っておく
    var allDayMoney: [[[[Int]]]] = [[[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
]
    var allDaySubCategoryName: [[[[String]]]] = [                   [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
                                                                    [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]],
    ]

    static var calendarViewControllerInstance = CalendarViewController()

    private let cellId = "cellId"

    let dateManager = DateManager()

    let currentDate = Date()
    let currentMonth = DateFormatter()
    let currentYear = DateFormatter()
    let currentDay = DateFormatter()

    var sabun: Int!

    //スクロールビューの高さ
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    //カレンダーのインスタンス化
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarViewHeightConstraint: NSLayoutConstraint!
    
    //コレクションビューのインスタンス化
    @IBOutlet weak var dateDiaryCollectionView: UICollectionView!
    
    //InputViewControllerに渡す変数
    var today = ""
    var year = ""
    var month = ""
    var day = ""
    //05月と0が入る形で渡す
    var passMonth = ""
    
    //cellのtableviewのcell数を決める配列
    var recieveSubCategoryArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //今日の日付を保存
        today = dateFormatter(day: Date())
        
        setupLayout()
        
        let currentCellMonth = currentMonth.string(from: currentDate)
        getDayCategoryData(currentCellMonth: currentCellMonth)
    }

    private func setupLayout() {
        //Calendarの装飾
        calendar.appearance.headerTitleFont = UIFont(name: "XANO-mincho", size: 14)
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayFont = UIFont(name: "XANO-mincho", size: 14)
        calendar.appearance.weekdayTextColor = .black

        //CollectionViewの登録
        dateDiaryCollectionView.register(UINib(nibName: "dateDiaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
    }
    
    func getDayCategoryData(currentCellMonth: String) {
        print("読み込まれるよ~~~~~~~~~~~~~~~~ーーーーーーーーーーーー")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let year = currentYear.string(from: currentDate)
        //引数はletだからvarに変換
        var currentCellMonth = currentCellMonth
        
        db.collection("\(year)subCategoryIncomeAndExpenditure").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("使用金額の取得に失敗しました。\(err)")
                return
            } else {
                //データの受け取り
                guard let data = snapshot?.data() else { return }
                print("data: \(data)")
                //Firestoreを読み取る際に0をつけないと読み取れない
                switch currentCellMonth {
                case "1":
                    currentCellMonth = "0\(currentCellMonth)"
                case "2":
                    currentCellMonth = "0\(currentCellMonth)"
                case "3":
                    currentCellMonth = "0\(currentCellMonth)"
                case "4":
                    currentCellMonth = "0\(currentCellMonth)"
                case "5":
                    currentCellMonth = "0\(currentCellMonth)"
                case "6":
                    currentCellMonth = "0\(currentCellMonth)"
                case "7":
                    currentCellMonth = "0\(currentCellMonth)"
                case "8":
                    currentCellMonth = "0\(currentCellMonth)"
                case "9":
                    currentCellMonth = "0\(currentCellMonth)"
                default:
                    break
                }
                print("currentCellMonth: \(currentCellMonth)")
                //入力されている日付を取得
                let recieveDayArray = DayArrayFromFireStore.init(dic: data, month: currentCellMonth)
                print("recieveDayArray: \(recieveDayArray)")
                guard let dayArray = recieveDayArray.monthDayArray else { return }
                print("dayArray: \(dayArray)")

                //日付毎のデータを取得
                self.dayMoneyFromFirestore(month: currentCellMonth, dayArray: dayArray, data: data)

                print("使用金額の取得に成功して代入しました。")
                print("costMonthSuperCategoryArray: \(self.costMonthSuperCategoryArray)")
                print("allDaySuperCategoryName: \(self.allDaySuperCategoryName)")
                print("allDayMoney: \(self.allDayMoney)")
                print("allDaySubCategoryName: \(self.allDaySubCategoryName)")

            }
        }
    }
    func dayMoneyFromFirestore(month: String, dayArray: [String], data: [String : Any]) {
        guard let intMonth = Int(month) else { return }
        for day in dayArray {
            costMonthSuperCategoryArray = []

            switch day {
            case "1":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 1)
                allDaySuperCategoryName[intMonth].remove(at: 0)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 0)
            case "2":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 2)
                allDaySuperCategoryName[intMonth].remove(at: 1)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 1)
            case "3":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 3)
                allDaySuperCategoryName[intMonth].remove(at: 2)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 2)
            case "4":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 4)
                allDaySuperCategoryName[intMonth].remove(at: 3)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 3)
            case "5":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 5)
                allDaySuperCategoryName[intMonth].remove(at: 4)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 4)
            case "6":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 6)
                allDaySuperCategoryName[intMonth].remove(at: 5)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 5)
            case "7":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 7)
                allDaySuperCategoryName[intMonth].remove(at: 6)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 6)
            case "8":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 8)
                allDaySuperCategoryName[intMonth].remove(at: 7)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 7)
            case "9":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 9)
                allDaySuperCategoryName[intMonth].remove(at: 8)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 8)
            case "10":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 10)
                allDaySuperCategoryName[intMonth].remove(at: 9)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 9)
            case "11":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 11)
                allDaySuperCategoryName[intMonth].remove(at: 10)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 10)
            case "12":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 12)
                allDaySuperCategoryName[intMonth].remove(at: 11)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 11)
            case "13":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 13)
                allDaySuperCategoryName[intMonth].remove(at: 12)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 12)
            case "14":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 14)
                allDaySuperCategoryName[intMonth].remove(at: 13)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 13)
            case "15":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 15)
                allDaySuperCategoryName[intMonth].remove(at: 14)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 14)
            case "16":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 16)
                allDaySuperCategoryName[intMonth].remove(at: 15)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 15)
            case "17":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 17)
                allDaySuperCategoryName[intMonth].remove(at: 16)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 16)
            case "18":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 18)
                allDaySuperCategoryName[intMonth].remove(at: 17)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 17)
            case "19":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 19)
                allDaySuperCategoryName[intMonth].remove(at: 18)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 18)
            case "20":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 20)
                allDaySuperCategoryName[intMonth].remove(at: 19)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 19)
            case "21":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 21)
                allDaySuperCategoryName[intMonth].remove(at: 20)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 20)
            case "22":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 22)
                allDaySuperCategoryName[intMonth].remove(at: 21)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 21)
            case "23":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 23)
                allDaySuperCategoryName[intMonth].remove(at: 22)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 22)
            case "24":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 24)
                allDaySuperCategoryName[intMonth].remove(at: 23)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 23)
            case "25":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 25)
                allDaySuperCategoryName[intMonth].remove(at: 24)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 24)
            case "26":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 26)
                allDaySuperCategoryName[intMonth].remove(at: 25)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 25)
            case "27":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 27)
                allDaySuperCategoryName[intMonth].remove(at: 26)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 26)
            case "28":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 28)
                allDaySuperCategoryName[intMonth].remove(at: 27)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 27)
            case "29":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 29)
                allDaySuperCategoryName[intMonth].remove(at: 28)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 28)
            case "30":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 30)
                allDaySuperCategoryName[intMonth].remove(at: 29)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 29)
            case "31":
                getSuperCategoryName(data: data, month: month, day: day, dayNum: 31)
                allDaySuperCategoryName[intMonth].remove(at: 30)
                allDaySuperCategoryName[intMonth].insert(costMonthSuperCategoryArray, at: 30)
            default:
                break
            }
        }
    }
    func getSuperCategoryName(data: [String : Any], month: String, day: String, dayNum: Int) {
        guard let intMonth = Int(month) else { return }
        //重複を避けるために初期化
        allDayMoney[intMonth][dayNum - 1] = []
        allDaySubCategoryName[intMonth][dayNum - 1] = []
        //親カテゴリー名前を取得
        let recieveDaySuperCategoryNameArray = DaySuperCategoryArrayFromFireStore.init(dic: data, month: month, day: day)
        guard let daySuperCategoryNameArray = recieveDaySuperCategoryNameArray.daySuperCategoryNameArray else { return }
        print("daySuperCategoryNameArray: \(daySuperCategoryNameArray)")
        for daySuperCaegoryName in daySuperCategoryNameArray {
            //親カテゴリー名前を元にサブカテゴリー名前を取得
            let recieveDaySubCategoryArray = DaySubCategoryArrayFromFireStore.init(dic: data, month: month, superCategoryName: daySuperCaegoryName, day: day)
            guard let daySubCategoryNameArray = recieveDaySubCategoryArray.daySubCategoryNameArray else { return }
            print("daySubCategoryNameArray: \(daySubCategoryNameArray)")
            //サブカテゴリーの個数を格納する→tableviewの個数になる

            allDaySubCategoryName[intMonth][dayNum - 1].append(daySubCategoryNameArray)
            let orderedSet:NSOrderedSet = NSOrderedSet(array: allDaySubCategoryName[intMonth][dayNum - 1])
            allDaySubCategoryName[intMonth][dayNum - 1] = orderedSet.array as! [[String]]

            print("代入した後allDaySubCategoryName:\(allDaySubCategoryName)")
            recieveSubCategoryArray.append(contentsOf: daySubCategoryNameArray)
            getDayMoney(daySubCategoryNameArray: daySubCategoryNameArray, data: data, month: month, day: day, dayNum: dayNum)
            switch daySuperCaegoryName {
            case "食費":
                // ???: daySubCategoryArrayは何のためにある？

                costMonthSuperCategoryArray.append("食費")
            case "日用品":
                costMonthSuperCategoryArray.append("日用品")
            case "服飾":

                costMonthSuperCategoryArray.append("服飾")
            case "健康":

                costMonthSuperCategoryArray.append("健康")
            case "交際":

                costMonthSuperCategoryArray.append("交際")
            case "趣味":

                costMonthSuperCategoryArray.append("趣味")
            case "教養":

                costMonthSuperCategoryArray.append("教養")
            case "交通":

                costMonthSuperCategoryArray.append("交通")
            case "美容":

                costMonthSuperCategoryArray.append("美容")
            case "観光":

                costMonthSuperCategoryArray.append("観光")
            case "車":

                costMonthSuperCategoryArray.append("車")
            case "バイク":

                costMonthSuperCategoryArray.append("バイク")
            case "通信":

                costMonthSuperCategoryArray.append("通信")
            case "水道代":

                costMonthSuperCategoryArray.append("水道代")
            case "ガス代":

                costMonthSuperCategoryArray.append("ガス代")
            case "電気代":

                costMonthSuperCategoryArray.append("電気代")
            case "保険":

                costMonthSuperCategoryArray.append("保険")
            case "税金":

                costMonthSuperCategoryArray.append("税金")
            case "住宅":

                costMonthSuperCategoryArray.append("住宅")
            case "医療":

                costMonthSuperCategoryArray.append("医療")
            case "ペット":

                costMonthSuperCategoryArray.append("ペット")
            default:
                break

            }
        }
    }
    //親カテゴリーによって格納する配列を変えていく
    func getDayMoney(daySubCategoryNameArray: [String], data: [String : Any], month: String, day: String, dayNum: Int) {
        guard let intMonth = Int(month) else { return }
        print("サブカテゴリー名前配列daySubCategoryNameArray:\(daySubCategoryNameArray)")
        var dayMoneyArray: [Int] = []
        for daySubCaegoryName in daySubCategoryNameArray {
            //サブカテゴリー名前をもとにdayId配列を取得
            let recieveDaySubCategoryId = DayIdArrayFromFireStore.init(dic: data, month: month, day: day, subCategoryName: daySubCaegoryName)
            guard let daySubCategoryIdArray = recieveDaySubCategoryId.daySubCategoryIdArray else { return }
            print("daySubCategoryIdArray: \(daySubCategoryIdArray)")
            for dayId in daySubCategoryIdArray {
                //dayId配列をもとに日にち毎のお金を取得
                let recieveDaySubCategoryMoney = DaySubCategoryMoneyFromFireStore.init(dic: data, month: month, day: day, subCategoryName: daySubCaegoryName, dayId: dayId)
                guard let dayMoney = recieveDaySubCategoryMoney.daySubCategoryMoney else { return }
                //サブカテゴリーをどんどん入れていい理由は表示するときに親カテゴリーで分けられているからそのまま配列の順番で表示する
                //日にち毎のお金を格納
                //引数は定数letだからvarに変換する
                print("daySubCaegoryName: \(daySubCaegoryName)")
                dayMoneyArray.append(dayMoney)
                print("dayMoney:\(dayMoney)")
            }
        }
        print("dayMoneyArray:\(dayMoneyArray)")
        //1~31日までのデータを格納していく　配列に対応するために-1
        //サブカテゴリーの名前配列と一緒の数にする
        if allDayMoney[intMonth][dayNum - 1].count < allDaySubCategoryName[intMonth][dayNum - 1].count {
            allDayMoney[intMonth][dayNum - 1].append(dayMoneyArray)
            
            print("allDaySubCategoryName[intMonth][dayNum - 1].count:\(allDaySubCategoryName[intMonth][dayNum - 1].count)")
            print("allDayMoney[intMonth][dayNum - 1].count:\(allDayMoney[intMonth][dayNum - 1].count)")
        }
        
        print("代入した後allDayMoney:\(allDayMoney)")
    }
}
//Calendarのdelegate
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    //日付のマスの色
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return .clear
    }
    //日付の枠線の色
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        //dateは表示する月の日数分だけ呼ばれて日付ごとに渡されるデータを変えていく
        //var today==Date()でインスタンス化されると今日の日付が生成される
        if dateFormatter(day: date) == today {
            return .black
        }
        return .clear
    }
    //日付の枠線の丸具合
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 0.5
    }
    //日付の数字の色
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //日曜==1か土曜==7かの判定
        if judgeWeekday(date) == 1
        {
            return UIColor(red: 150/255, green: 30/255, blue: 0/255, alpha: 0.9)
        }
        else if judgeWeekday(date) == 7
        {
            return UIColor(red: 0/255, green: 30/255, blue: 150/255, alpha: 0.9)
        }
        //祝日の判定
        if judgeHoliday(date)
        {
            return UIColor(red: 150/255, green: 30/255, blue: 0/255, alpha: 0.9)
        }
        return .black
    }

    //選択された時
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        let calendar = Calendar(identifier: .gregorian)

        year = String(calendar.component(.year, from: date))
        //比較のためのmonth
        month = String(calendar.component(.month, from: date))
        
        day = String(calendar.component(.day, from: date))

        print("選択した日付\(year)/\(month)/\(day)")

        currentMonth.dateFormat = "MM"
        currentYear.dateFormat = "yyyy"

        if Int(year) == Int(currentYear.string(from: currentDate))! {
            //前に戻ったら
            if Int(month)! < Int(currentMonth.string(from: currentDate))! {
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))!
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.preMonthCalendar(preMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            } else if Int(month)! > Int(currentMonth.string(from: currentDate))! { //先に進んだら
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))!
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.nextMonthCalendar(nextMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            } else if Int(month)! == Int(currentMonth.string(from: currentDate))! {
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))!
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.preMonthCalendar(preMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            }
        } else if Int(year)! < Int(currentYear.string(from: currentDate))! {
            let yearSabun = Int(year)! - Int(currentYear.string(from: currentDate))!
            //前に戻ったら
            if Int(month)! < Int(currentMonth.string(from: currentDate))! {
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))! - 12 * -yearSabun
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.preMonthCalendar(preMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            } else if Int(month)! > Int(currentMonth.string(from: currentDate))! {
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))! - 12 * -yearSabun
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.preMonthCalendar(preMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            } else if Int(month)! == Int(currentMonth.string(from: currentDate))! {
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))! - 12 * -yearSabun
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.preMonthCalendar(preMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            }
        } else if Int(year)! > Int(currentYear.string(from: currentDate))! {
            print("こっちに入ったよ")
            let yearSabun = Int(year)! - Int(currentYear.string(from: currentDate))!
            //先に進んだら
            if Int(month)! < Int(currentMonth.string(from: currentDate))! {
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))! + 12 * yearSabun
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.nextMonthCalendar(nextMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            } else if Int(month)! > Int(currentMonth.string(from: currentDate))! {
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))! + 12 * yearSabun
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.nextMonthCalendar(nextMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            } else if Int(month)! == Int(currentMonth.string(from: currentDate))! {
                dateManager.resetMonthCalendar(resetMonthData: sabun ?? 0)
                sabun = Int(month)! - Int(currentMonth.string(from: currentDate))! + 12 * yearSabun
                print("ああああああああああああああ\(String(describing: sabun))")
                dateManager.preMonthCalendar(preMonthData: sabun)
                dateDiaryCollectionView.reloadData()
            }
        }
        
        getDayCategoryData(currentCellMonth: month)

        performSegue(withIdentifier: "InputViewController", sender: nil)
    }
    //InputViewControllerへ値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputViewController" {
            let inputViewController = segue.destination as! InputViewController
            inputViewController.calendarYearReciver = year
            inputViewController.calendarMonthReciver = month
            inputViewController.calendarDayReciver = day
            //遷移先がpageshhetでもdismiss時にviewwillApeearが呼ばれるようにする
            inputViewController.presentationController?.delegate = self
        }
    }

    //今日の日付を取得
    func dateFormatter(day: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: day)
    }

    //曜日判定(日曜日:1/土曜日:7)
    func judgeWeekday(_ date: Date) -> Int
    {
        //Xcodeに元から用意されているCalendar()インスタンスの機能
        //.gregorianはグレゴリオ暦のことで西暦の日付指定
        let calendar = Calendar(identifier: .gregorian)
        //Calendarのcomponent()メソッドは第一引数に「.year」「.month」「.weekday」「.day」を指定して第二引数のfromにData型の値を入れることで日曜日1~土曜日7の値を返してくれる→これで曜日を判定
        return calendar.component(.weekday, from: date)
    }
    //祝日判定を行い結果を返すメソッド（true:祝日）
    func judgeHoliday(_ date: Date) -> Bool
    {
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        //.judgeJapaneseHoliday(year: let year = calendar.component(.year, from: date), month: let month = calendar.component(.month, from: date), day: let day = calendar.component(.day, from: date))取ってきた値を代入している。結果はtrueかfalseなので最後に結果をreturnしている。
        let holiday = CalculateCalendarLogic()
        let judgeHoliday = holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        return judgeHoliday
    }
    //date型　-> 年月日をIntで取得
    func getDay(_ date: Date) -> (Int,Int,Int) {
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return (year,month,day)
    }
}


//Calendarの下にあるCollectionCellのdelegate
extension CalendarViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateManager.daysAcquisition()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dateDiaryCollectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! dateDiaryCollectionViewCell
        cell.tableH1Label.text = dateManager.conversionDateFormat(index: indexPath.row)
        cell.currentCellDay = dateManager.getCurrentCellDay(index: indexPath.row)
        cell.currentCellMonth = dateManager.getCurrentCellMonth(index: indexPath.row)
        getDayCategoryData(currentCellMonth: cell.currentCellMonth)
        switch dateManager.getCurrentCellMonth(index: indexPath.row) {
        case "1":
            switchDay(index: indexPath.row, cell: cell, intMonth: 1)
        case "2":
            switchDay(index: indexPath.row, cell: cell, intMonth: 2)
        case "3":
            switchDay(index: indexPath.row, cell: cell, intMonth: 3)
        case "4":
            switchDay(index: indexPath.row, cell: cell, intMonth: 4)
        case "5":
            print("5月通ったよ")
            switchDay(index: indexPath.row, cell: cell, intMonth: 5)
        case "6":
            print("6月通ったよ")
            switchDay(index: indexPath.row, cell: cell, intMonth: 6)
        case "7":
            switchDay(index: indexPath.row, cell: cell, intMonth: 7)
        case "8":
            switchDay(index: indexPath.row, cell: cell, intMonth: 8)
        case "9":
            switchDay(index: indexPath.row, cell: cell, intMonth: 9)
        case "10":
            switchDay(index: indexPath.row, cell: cell, intMonth: 10)
        case "11":
            switchDay(index: indexPath.row, cell: cell, intMonth: 11)
        case "12":
            switchDay(index: indexPath.row, cell: cell, intMonth: 12)
        default:
            break
        }
        //tableviewの個数を渡す
        cell.recieveSubCategoryArray = recieveSubCategoryArray
        cell.dateCategoryCollectionView.reloadData()
        return cell
    }
    func switchDay(index: Int, cell: dateDiaryCollectionViewCell, intMonth: Int) {
        switch dateManager.getCurrentCellDay(index: index) {
        case "1":
            cell.categoryCount = allDaySuperCategoryName[intMonth][0].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][0]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][0]
            cell.recieveSubMoney = allDayMoney[intMonth][0]
            cell.recieveCellDay = 1
            print("cell.recieveSuperCategoryName: \(cell.recieveSuperCategoryName)")
            print("cell.categoryCount: \(cell.categoryCount)")
        case "2":
            cell.categoryCount = allDaySuperCategoryName[intMonth][1].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][1]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][1]
            cell.recieveSubMoney = allDayMoney[intMonth][1]
            cell.recieveCellDay = 2
            print("cell.recieveSuperCategoryName: \(cell.recieveSuperCategoryName)")
            print("cell.categoryCount: \(cell.categoryCount)")
        case "3":
            cell.categoryCount = allDaySuperCategoryName[intMonth][2].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][2]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][2]
            cell.recieveSubMoney = allDayMoney[intMonth][2]
            cell.recieveCellDay = 3
        case "4":
            cell.categoryCount = allDaySuperCategoryName[intMonth][3].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][3]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][3]
            cell.recieveSubMoney = allDayMoney[intMonth][3]
            cell.recieveCellDay = 4
        case "5":
            cell.categoryCount = allDaySuperCategoryName[intMonth][4].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][4]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][4]
            cell.recieveSubMoney = allDayMoney[intMonth][4]
            cell.recieveCellDay = 5
        case "6":
            cell.categoryCount = allDaySuperCategoryName[intMonth][5].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][5]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][5]
            cell.recieveSubMoney = allDayMoney[intMonth][5]
            cell.recieveCellDay = 6
        case "7":
            cell.categoryCount = allDaySuperCategoryName[intMonth][6].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][6]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][6]
            cell.recieveSubMoney = allDayMoney[intMonth][6]
//            cell.recieveCellDay = 7
        case "8":
            cell.categoryCount = allDaySuperCategoryName[intMonth][7].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][7]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][7]
            cell.recieveSubMoney = allDayMoney[intMonth][7]
            cell.recieveCellDay = 8
        case "9":
            cell.categoryCount = allDaySuperCategoryName[intMonth][8].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][8]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][8]
            cell.recieveSubMoney = allDayMoney[intMonth][8]
            cell.recieveCellDay = 9
        case "10":
            cell.categoryCount = allDaySuperCategoryName[intMonth][9].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][9]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][9]
            cell.recieveSubMoney = allDayMoney[intMonth][9]
        case "11":
            cell.categoryCount = allDaySuperCategoryName[intMonth][10].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][10]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][10]
            cell.recieveSubMoney = allDayMoney[intMonth][10]
        case "12":
            cell.categoryCount = allDaySuperCategoryName[intMonth][11].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][11]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][11]
            cell.recieveSubMoney = allDayMoney[intMonth][11]
        case "13":
            cell.categoryCount = allDaySuperCategoryName[intMonth][12].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][12]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][12]
            cell.recieveSubMoney = allDayMoney[intMonth][12]
        case "14":
            cell.categoryCount = allDaySuperCategoryName[intMonth][13].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][13]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][13]
            cell.recieveSubMoney = allDayMoney[intMonth][13]
        case "15":
            cell.categoryCount = allDaySuperCategoryName[intMonth][14].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][14]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][14]
            cell.recieveSubMoney = allDayMoney[intMonth][14]
        case "16":
            cell.categoryCount = allDaySuperCategoryName[intMonth][15].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][15]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][15]
            cell.recieveSubMoney = allDayMoney[intMonth][15]
        case "17":
            cell.categoryCount = allDaySuperCategoryName[intMonth][16].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][16]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][16]
            cell.recieveSubMoney = allDayMoney[intMonth][16]
        case "18":
            cell.categoryCount = allDaySuperCategoryName[intMonth][17].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][17]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][17]
            cell.recieveSubMoney = allDayMoney[intMonth][17]
        case "19":
            cell.categoryCount = allDaySuperCategoryName[intMonth][18].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][18]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][18]
            cell.recieveSubMoney = allDayMoney[intMonth][18]
        case "20":
            cell.categoryCount = allDaySuperCategoryName[intMonth][19].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][19]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][19]
            cell.recieveSubMoney = allDayMoney[intMonth][19]
        case "21":
            cell.categoryCount = allDaySuperCategoryName[intMonth][20].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][20]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][20]
            cell.recieveSubMoney = allDayMoney[intMonth][20]
        case "22":
            cell.categoryCount = allDaySuperCategoryName[intMonth][21].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][21]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][21]
            cell.recieveSubMoney = allDayMoney[intMonth][21]
        case "23":
            cell.categoryCount = allDaySuperCategoryName[intMonth][22].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][22]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][22]
            cell.recieveSubMoney = allDayMoney[intMonth][22]
        case "24":
            cell.categoryCount = allDaySuperCategoryName[intMonth][23].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][23]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][23]
            cell.recieveSubMoney = allDayMoney[intMonth][23]
        case "25":
            cell.categoryCount = allDaySuperCategoryName[intMonth][24].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][24]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][24]
            cell.recieveSubMoney = allDayMoney[intMonth][24]
        case "26":
            cell.categoryCount = allDaySuperCategoryName[intMonth][25].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][25]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][25]
            cell.recieveSubMoney = allDayMoney[intMonth][25]
        case "27":
            cell.categoryCount = allDaySuperCategoryName[intMonth][26].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][26]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][26]
            cell.recieveSubMoney = allDayMoney[intMonth][26]
        case "28":
            cell.categoryCount = allDaySuperCategoryName[intMonth][27].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][27]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][27]
            cell.recieveSubMoney = allDayMoney[intMonth][27]
        case "29":
            cell.categoryCount = allDaySuperCategoryName[intMonth][28].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][28]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][28]
            cell.recieveSubMoney = allDayMoney[intMonth][28]
        case "30":
            cell.categoryCount = allDaySuperCategoryName[intMonth][29].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][29]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][29]
            cell.recieveSubMoney = allDayMoney[intMonth][29]
            cell.recieveCellDay = 30
        case "31":
            cell.categoryCount = allDaySuperCategoryName[intMonth][30].count
            cell.recieveSuperCategoryName = allDaySuperCategoryName[intMonth][30]
            cell.recieveSubCategoryName = allDaySubCategoryName[intMonth][30]
            cell.recieveSubMoney = allDayMoney[intMonth][30]
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 2, left: 2, bottom: 2, right: 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // ここの値を一番大きいセルの値にする
        let cellMaxHeight: CGFloat = 32 * 4
        let cellCount: CGFloat = 3
        let cellLabelHeight: CGFloat = 44 * 3
        let cellMargin: CGFloat = 10
        let cellMarginCount: CGFloat = cellCount
        
        // 一番大きいセルの値+カレンダー+余白でスクロールビューの高さを取得する
        viewHeightConstraint.constant = (calendarViewHeightConstraint.constant + cellMargin * cellMarginCount + cellMaxHeight * cellCount + cellLabelHeight)
        
        return CGSize(width: dateDiaryCollectionView.bounds.width / 3, height: cellMargin * cellMarginCount + cellMaxHeight * cellCount + cellLabelHeight - 10)
    }
}
//戻ったときに通知される処理
extension CalendarViewController: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // Modal画面から戻った際の画面の更新処理を行う。
        print("calendarViewを戻ってリロードするよ")
        self.dateDiaryCollectionView.reloadData()
    }
}
