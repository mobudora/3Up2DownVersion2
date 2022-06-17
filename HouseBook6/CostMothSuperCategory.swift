//
//  CostMothSuperCategory.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/20.
//

import Foundation

//受け取った支出親カテゴリー情報の整理
struct CostMothSuperCategoryFromFireStore {

    //Cost親カテゴリーの名前と順番を格納する変数
    let foodMonthSuperCategoryFromFirestore: Int!
    let dailyGoodsMonthSuperCategoryFromFirestore: Int!
    let clothMonthSuperCategoryFromFirestore: Int!
    let healthdMonthSuperCategoryFromFirestore: Int!
    let datingMonthSuperCategoryFromFirestore: Int!
    let hobbiesMonthSuperCategoryFromFirestore: Int!
    let liberalArtsMonthSuperCategoryFromFirestore: Int!
    let transportationMonthSuperCategoryFromFirestore: Int!
    let cosmetologyMonthSuperCategoryFromFirestore: Int!
    let sightseeingMonthSuperCategoryFromFirestore: Int!
    let carMonthSuperCategoryFromFirestore: Int!
    let motorcycleMonthSuperCategoryFromFirestore: Int!
    let netWorkMonthSuperCategoryFromFirestore: Int!
    let waterMonthSuperCategoryFromFirestore: Int!
    let gasMonthSuperCategoryFromFirestore: Int!
    let electricityMonthSuperCategoryFromFirestore: Int!
    let insuranceMonthSuperCategoryFromFirestore: Int!
    let taxMonthSuperCategoryFromFirestore: Int!
    let housingMonthSuperCategoryFromFirestore: Int!
    let medicalMonthSuperCategoryFromFirestore: Int!
    let petMonthSuperCategoryFromFirestore: Int!

    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any], month: String){
        self.foodMonthSuperCategoryFromFirestore = dic["\(month)食費SumMoney"] as! Int?
        self.dailyGoodsMonthSuperCategoryFromFirestore = dic["\(month)日用品SumMoney"] as! Int?
        self.clothMonthSuperCategoryFromFirestore = dic["\(month)服飾SumMoney"] as! Int?
        self.healthdMonthSuperCategoryFromFirestore = dic["\(month)健康SumMoney"] as! Int?
        self.datingMonthSuperCategoryFromFirestore = dic["\(month)交際SumMoney"] as! Int?
        self.hobbiesMonthSuperCategoryFromFirestore = dic["\(month)趣味SumMoney"] as! Int?
        self.liberalArtsMonthSuperCategoryFromFirestore = dic["\(month)教養SumMoney"] as! Int?
        self.transportationMonthSuperCategoryFromFirestore = dic["\(month)交通SumMoney"] as! Int?
        self.cosmetologyMonthSuperCategoryFromFirestore = dic["\(month)美容SumMoney"] as! Int?
        self.sightseeingMonthSuperCategoryFromFirestore = dic["\(month)観光SumMoney"] as! Int?
        self.carMonthSuperCategoryFromFirestore = dic["\(month)車SumMoney"] as! Int?
        self.motorcycleMonthSuperCategoryFromFirestore = dic["\(month)バイクSumMoney"] as! Int?
        self.netWorkMonthSuperCategoryFromFirestore = dic["\(month)通信SumMoney"] as! Int?
        self.waterMonthSuperCategoryFromFirestore = dic["\(month)水道代SumMoney"] as! Int?
        self.gasMonthSuperCategoryFromFirestore = dic["\(month)ガス代SumMoney"] as! Int?
        self.electricityMonthSuperCategoryFromFirestore = dic["\(month)電気代SumMoney"] as! Int?
        self.insuranceMonthSuperCategoryFromFirestore = dic["\(month)保険SumMoney"] as! Int?
        self.taxMonthSuperCategoryFromFirestore = dic["\(month)税金SumMoney"] as! Int?
        self.housingMonthSuperCategoryFromFirestore = dic["\(month)住宅SumMoney"] as! Int?
        self.medicalMonthSuperCategoryFromFirestore = dic["\(month)医療SumMoney"] as! Int?
        self.petMonthSuperCategoryFromFirestore = dic["\(month)ペットSumMoney"] as! Int?
    }
}
