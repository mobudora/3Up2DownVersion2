//
//  FixedCost.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/16.
//

import Foundation
import Firebase

//受け取ったカテゴリー情報の整理
struct FixedCostFromFirestore {

    //食費のお金を格納する
    let foodMoneyFromFirestore: Int!
    let foodFixedCostSubCategoryArrayFromFirestore: [String]!
    //日用品のお金を格納する
    let dailyGoodsMoneyFromFirestore: Int!
    let dailyGoodsFixedCostSubCategoryArrayFromFirestore: [String]!
    //服飾のお金を格納する
    let clothMoneyFromFirestore: Int!
    let clothFixedCostSubCategoryArrayFromFirestore: [String]!
    //健康のお金を格納する
    let healthMoneyFromFirestore: Int!
    let healthFixedCostSubCategoryArrayFromFirestore: [String]!
    //交際のお金を格納する
    let datingMoneyFromFirestore: Int!
    let datingFixedCostSubCategoryArrayFromFirestore: [String]!
    //趣味のお金を格納する
    let hobbiesMoneyFromFirestore: Int!
    let hobbiesFixedCostSubCategoryArrayFromFirestore: [String]!
    //教養のお金を格納する
    let liberalArtsMoneyFromFirestore: Int!
    let liberalArtsFixedCostSubCategoryArrayFromFirestore: [String]!
    //交通のお金を格納する
    let transportationMoneyFromFirestore: Int!
    let transportationFixedCostSubCategoryArrayFromFirestore: [String]!
    //美容のお金を格納する
    let cosmetologyMoneyFromFirestore: Int!
    let cosmetologyFixedCostSubCategoryArrayFromFirestore: [String]!
    //観光のお金を格納する
    let sightseeingMoneyFromFirestore: Int!
    let sightseeingFixedCostSubCategoryArrayFromFirestore: [String]!
    //車のお金を格納する
    let carMoneyFromFirestore: Int!
    let carFixedCostSubCategoryArrayFromFirestore: [String]!
    //バイクのお金を格納する
    let motorcycleMoneyFromFirestore: Int!
    let motorcycleFixedCostSubCategoryArrayFromFirestore: [String]!
    //通信のお金を格納する
    let netWorkMoneyFromFirestore: Int!
    let netWorkFixedCostSubCategoryArrayFromFirestore: [String]!
    //水道代のお金を格納する
    let waterMoneyFromFirestore: Int!
    let waterFixedCostSubCategoryArrayFromFirestore: [String]!
    //ガス代のお金を格納する
    let gasMoneyFromFirestore: Int!
    let gasFixedCostSubCategoryArrayFromFirestore: [String]!
    //電気代のお金を格納する
    let electricityMoneyFromFirestore: Int!
    let electricityFixedCostSubCategoryArrayFromFirestore: [String]!
    //保険のお金を格納する
    let insuranceMoneyFromFirestore: Int!
    let insuranceFixedCostSubCategoryArrayFromFirestore: [String]!
    //税金のお金を格納する
    let taxMoneyFromFirestore: Int!
    let taxFixedCostSubCategoryArrayFromFirestore: [String]!
    //住宅のお金を格納する
    let housingMoneyFromFirestore: Int!
    let housingFixedCostSubCategoryArrayFromFirestore: [String]!
    //医療のお金を格納する
    let medicalMoneyFromFirestore: Int!
    let medicalFixedCostSubCategoryArrayFromFirestore: [String]!
    //ペットのお金を格納する
    let petMoneyFromFirestore: Int!
    let petFixedCostSubCategoryArrayFromFirestore: [String]!
    
    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any], month: String){
        self.foodMoneyFromFirestore = dic["\(month)食費固定費SumMoney"] as! Int?
        self.foodFixedCostSubCategoryArrayFromFirestore = dic["\(month)食費固定費配列"] as! [String]?
        self.dailyGoodsMoneyFromFirestore = dic["\(month)日用品固定費SumMoney"] as! Int?
        self.dailyGoodsFixedCostSubCategoryArrayFromFirestore = dic["\(month)日用品固定費配列"] as! [String]?
        self.clothMoneyFromFirestore = dic["\(month)服飾固定費SumMoney"] as! Int?
        self.clothFixedCostSubCategoryArrayFromFirestore = dic["\(month)服飾固定費配列"] as! [String]?
        self.healthMoneyFromFirestore = dic["\(month)健康固定費SumMoney"] as! Int?
        self.healthFixedCostSubCategoryArrayFromFirestore = dic["\(month)健康固定費配列"] as! [String]?
        self.datingMoneyFromFirestore = dic["\(month)交際固定費SumMoney"] as! Int?
        self.datingFixedCostSubCategoryArrayFromFirestore = dic["\(month)交際固定費配列"] as! [String]?
        self.hobbiesMoneyFromFirestore = dic["\(month)趣味固定費SumMoney"] as! Int?
        self.hobbiesFixedCostSubCategoryArrayFromFirestore = dic["\(month)趣味固定費配列"] as! [String]?
        self.liberalArtsMoneyFromFirestore = dic["\(month)教養固定費SumMoney"] as! Int?
        self.liberalArtsFixedCostSubCategoryArrayFromFirestore = dic["\(month)教養固定費配列"] as! [String]?
        self.transportationMoneyFromFirestore = dic["\(month)交通固定費SumMoney"] as! Int?
        self.transportationFixedCostSubCategoryArrayFromFirestore = dic["\(month)交通固定費配列"] as! [String]?
        self.cosmetologyMoneyFromFirestore = dic["\(month)美容固定費SumMoney"] as! Int?
        self.cosmetologyFixedCostSubCategoryArrayFromFirestore = dic["\(month)美容固定費配列"] as! [String]?
        self.sightseeingMoneyFromFirestore = dic["\(month)観光固定費SumMoney"] as! Int?
        self.sightseeingFixedCostSubCategoryArrayFromFirestore = dic["\(month)観光固定費配列"] as! [String]?
        self.carMoneyFromFirestore = dic["\(month)車固定費SumMoney"] as! Int?
        self.carFixedCostSubCategoryArrayFromFirestore = dic["\(month)車固定費配列"] as! [String]?
        self.motorcycleMoneyFromFirestore = dic["\(month)バイク固定費SumMoney"] as! Int?
        self.motorcycleFixedCostSubCategoryArrayFromFirestore = dic["\(month)バイク固定費配列"] as! [String]?
        self.netWorkMoneyFromFirestore = dic["\(month)通信固定費SumMoney"] as! Int?
        self.netWorkFixedCostSubCategoryArrayFromFirestore = dic["\(month)通信固定費配列"] as! [String]?
        self.waterMoneyFromFirestore = dic["\(month)水道代固定費SumMoney"] as! Int?
        self.waterFixedCostSubCategoryArrayFromFirestore = dic["\(month)水道代固定費配列"] as! [String]?
        self.gasMoneyFromFirestore = dic["\(month)ガス代固定費SumMoney"] as! Int?
        self.gasFixedCostSubCategoryArrayFromFirestore = dic["\(month)ガス代固定費配列"] as! [String]?
        self.electricityMoneyFromFirestore = dic["\(month)電気代固定費SumMoney"] as! Int?
        self.electricityFixedCostSubCategoryArrayFromFirestore = dic["\(month)電気代固定費配列"] as! [String]?
        self.insuranceMoneyFromFirestore = dic["\(month)保険固定費SumMoney"] as! Int?
        self.insuranceFixedCostSubCategoryArrayFromFirestore = dic["\(month)保険固定費配列"] as! [String]?
        self.taxMoneyFromFirestore = dic["\(month)税金固定費SumMoney"] as! Int?
        self.taxFixedCostSubCategoryArrayFromFirestore = dic["\(month)税金固定費配列"] as! [String]?
        self.housingMoneyFromFirestore = dic["\(month)住宅固定費SumMoney"] as! Int?
        self.housingFixedCostSubCategoryArrayFromFirestore = dic["\(month)住宅固定費配列"] as! [String]?
        self.medicalMoneyFromFirestore = dic["\(month)医療固定費SumMoney"] as! Int?
        self.medicalFixedCostSubCategoryArrayFromFirestore = dic["\(month)医療固定費配列"] as! [String]?
        self.petMoneyFromFirestore = dic["\(month)ペット固定費SumMoney"] as! Int?
        self.petFixedCostSubCategoryArrayFromFirestore = dic["\(month)ペット固定費配列"] as! [String]?
    }
}

