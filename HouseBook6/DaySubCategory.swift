//
//  DaySubCategory.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/24.
//

import Foundation

//選択している月の入力がされている日付を取得する
struct DayArrayFromFireStore {

    let monthDayArray: [String]!

    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any], month: String){
        print("\(month)Day配列")
        self.monthDayArray = dic["\(month)Day配列"] as! [String]?
    }
}

//サブカテゴリーのdayId配列を取得する
struct DayIdArrayFromFireStore {

    let daySubCategoryIdArray: [String]!

    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any], month: String, day: String, subCategoryName: String){
        self.daySubCategoryIdArray = dic["\(month)\(day)\(subCategoryName)dayId配列"] as! [String]?
    }
}

//サブカテゴリーのsumMoneyを取得する
struct DaySubCategoryFromFireStore {

    let daySubCategoryMoney: Int!

    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any], month: String, subCategoryName: String){
        self.daySubCategoryMoney = dic["\(month)\(subCategoryName)SumMoney"] as! Int?
    }
}


//日にち毎のお金を受け取る
struct DaySubCategoryMoneyFromFireStore {

    let daySubCategoryMoney: Int!

    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any], month: String, day: String, subCategoryName: String, dayId: String){
        self.daySubCategoryMoney = dic["\(month)\(day)\(subCategoryName)\(dayId)"] as! Int?
    }
}

//日にち毎の親カテゴリー名前配列を取得する
struct DaySuperCategoryArrayFromFireStore {

    let daySuperCategoryNameArray: [String]!

    init(dic: [String: Any], month: String, day: String){
        self.daySuperCategoryNameArray = dic["\(month)\(day)カテゴリー配列"] as! [String]?
    }
}

//日にち毎のサブカテゴリー名前配列を取得する
struct DaySubCategoryArrayFromFireStore {

    let daySubCategoryNameArray: [String]!

    init(dic: [String: Any], month: String, superCategoryName: String, day: String){
        self.daySubCategoryNameArray = dic["\(month)\(day)\(superCategoryName)配列"] as! [String]?
    }
}
