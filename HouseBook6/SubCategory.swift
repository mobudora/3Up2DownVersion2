//
//  SubCategory.swift
//  HouseBook6
//
//  Created by Dora on 2022/05/06.
//

import Foundation
import Firebase

//受け取ったカテゴリー情報の整理
struct SubCategoryFromFirestore {
    //Costサブカテゴリーの名前と順番を格納する変数
    let costFoodSubIconNameFromFirestore: [String]
    let costDailyGoodsSubIconNameFromFirestore: [String]
    let costClothSubIconNameFromFirestore: [String]
    let costHealthSubIconNameFromFirestore: [String]
    let costDatingSubIconNameFromFirestore: [String]
    let costHobbiesSubIconNameFromFirestore: [String]
    let costLiberalArtsSubIconNameFromFirestore: [String]
    let costTransportationSubIconNameFromFirestore: [String]
    let costCosmetologySubIconNameFromFirestore: [String]
    let costSightseeingSubIconNameFromFirestore: [String]
    let costCarSubIconNameFromFirestore: [String]
    let costMotorcycleSubIconNameFromFirestore: [String]
    let costNetWorkSubIconNameFromFirestore: [String]
    let costWaterSubIconNameFromFirestore: [String]
    let costGasSubIconNameFromFirestore: [String]
    let costElectricitySubIconNameFromFirestore: [String]
    let costInsuranceSubIconNameFromFirestore: [String]
    let costTaxSubIconNameFromFirestore: [String]
    let costHousingSubIconNameFromFirestore: [String]
    let costMedicalSubIconNameFromFirestore: [String]
    let costPetSubIconNameFromFirestore: [String]
//    let costSettingSubIconNameFromFirestore: [String]
    
    //Income親カテゴリーの名前と順番を格納する変数
    let incomeSalarySubIconNameFromFirestore: [String]
    let incomeSideBusinessSubIconNameFromFirestore: [String]
    let incomeExtraordinarySubIconNameFromFirestore: [String]
    let incomeInvestmentSubIconNameFromFirestore: [String]
    let incomePrizeSubIconNameFromFirestore: [String]
//    let incomeSettingSubIconNameFromFirestore: [String]

    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any]){
        //cost配列
        self.costFoodSubIconNameFromFirestore = dic["costFoodSubIcon"] as! [String]
        self.costDailyGoodsSubIconNameFromFirestore = dic["costDailyGoodsSubIcon"] as! [String]
        self.costClothSubIconNameFromFirestore = dic["costClothSubIcon"] as! [String]
        self.costHealthSubIconNameFromFirestore = dic["costHealthSubIcon"] as! [String]
        self.costDatingSubIconNameFromFirestore = dic["costDatingSubIcon"] as! [String]
        self.costHobbiesSubIconNameFromFirestore = dic["costHobbiesSubIcon"] as! [String]
        self.costLiberalArtsSubIconNameFromFirestore = dic["costLiberalArtsSubIcon"] as! [String]
        self.costTransportationSubIconNameFromFirestore = dic["costTransportationSubIcon"] as! [String]
        self.costCosmetologySubIconNameFromFirestore = dic["costCosmetologySubIcon"] as! [String]
        self.costSightseeingSubIconNameFromFirestore = dic["costSightseeingSubIcon"] as! [String]
        self.costCarSubIconNameFromFirestore = dic["costCarSubIcon"] as! [String]
        self.costMotorcycleSubIconNameFromFirestore = dic["costMotorcycleSubIcon"] as! [String]
        self.costNetWorkSubIconNameFromFirestore = dic["costNetWorkSubIcon"] as! [String]
        self.costWaterSubIconNameFromFirestore = dic["costWaterSubIcon"] as! [String]
        self.costGasSubIconNameFromFirestore = dic["costGasSubIcon"] as! [String]
        self.costElectricitySubIconNameFromFirestore = dic["costElectricitySubIcon"] as! [String]
        self.costInsuranceSubIconNameFromFirestore = dic["costInsuranceSubIcon"] as! [String]
        self.costTaxSubIconNameFromFirestore = dic["costTaxSubIcon"] as! [String]
        self.costHousingSubIconNameFromFirestore = dic["costHousingSubIcon"] as! [String]
        self.costMedicalSubIconNameFromFirestore = dic["costMedicalSubIcon"] as! [String]
        self.costPetSubIconNameFromFirestore = dic["costPetSubIcon"] as! [String]
//        self.costSettingSubIconNameFromFirestore = dic["costSettingSubIcon"] as! [String]
        
        //income配列
        self.incomeSalarySubIconNameFromFirestore = dic["incomeSalarySubIcon"] as! [String]
        self.incomeSideBusinessSubIconNameFromFirestore = dic["incomeSideBusinessSubIcon"] as! [String]
        self.incomeExtraordinarySubIconNameFromFirestore = dic["incomeExtraordinarySubIcon"] as! [String]
        self.incomeInvestmentSubIconNameFromFirestore = dic["incomeInvestmentSubIcon"] as! [String]
        self.incomePrizeSubIconNameFromFirestore = dic["incomePrizeSubIcon"] as! [String]
//        self.incomeSettingSubIconNameFromFirestore = dic["incomeSettingSubIcon"] as! [String]
    }
}

struct SubCategoryIcon {

    //costサブカテゴリーの配列まとめ
    static var CostSubIcon = [
        CostFoodSubIcon,
        CostDailyGoodsSubIcon,
        CostClothingSubIcon,
        CostHealthSubIcon,
        CostDatingSubIcon,
        CostHobbiesSubIcon,
        CostLiberalArtsSubIcon,
        CostTransportationSubIcon,
        CostCosmetologySubIcon,
        CostSightseeingSubIcon,
        CostCarSubIcon,
        CostMotorcycleSubIcon,
        CostNetWorkSubIcon,
        CostWaterSubIcon,
        CostGasSubIcon,
        CostElectricitySubIcon,
        CostInsuranceSubIcon,
        CostTaxSubIcon,
        CostHousingSubIcon,
        CostMedicalSubIcon,
        CostPetSubIcon,
        CostSettingSubIcon
    ]
    
    //costの配列
    //食費のサブカテゴリー
    static var CostFoodSubIcon: [String: UIImage] = [
        "食料品": UIImage(systemName: "cart")!,
        "外食": UIImage(systemName: "cart")!,
        "朝ご飯": UIImage(systemName: "cart")!,
        "昼ご飯": UIImage(systemName: "cart")!,
        "晩ご飯": UIImage(systemName: "cart")!,
        "カフェ": UIImage(systemName: "cup.and.saucer")!,
        "お酒": UIImage(systemName: "cart")!,
        "ドンキ": UIImage(systemName: "cart")!,
        "MaxValue": UIImage(systemName: "cart")!,
        "その他": UIImage(systemName: "cart")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //日用品のサブカテゴリー
    static var CostDailyGoodsSubIcon: [String: UIImage] = [
        "消耗品": UIImage(systemName: "case")!,
        "生活雑貨": UIImage(systemName: "case")!,
        "タバコ": UIImage(systemName: "case")!,
        "嗜好品": UIImage(systemName: "case")!,
        "子供関連": UIImage(systemName: "case")!,
        "ペット関連": UIImage(systemName: "case")!,
        "ドンキ": UIImage(systemName: "case")!,
        "その他": UIImage(systemName: "case")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //服飾のサブカテゴリー
    static var CostClothingSubIcon: [String: UIImage] = [
        "上着": UIImage(systemName: "tshirt")!,
        "下着": UIImage(systemName: "tshirt")!,
        "ジャケット": UIImage(systemName: "tshirt")!,
        "Tシャツ": UIImage(systemName: "tshirt")!,
        "アクセサリー": UIImage(systemName: "tshirt")!,
        "クリーニング": UIImage(systemName: "tshirt")!,
        "スボン": UIImage(systemName: "tshirt")!,
        "帽子": UIImage(systemName: "tshirt")!,
        "眼鏡": UIImage(systemName: "tshirt")!,
        "靴下": UIImage(systemName: "tshirt")!,
        "靴": UIImage(systemName: "tshirt")!,
        "その他": UIImage(systemName: "tshirt")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //健康のサブカテゴリー
    static var CostHealthSubIcon: [String: UIImage] = [
        "化粧品": UIImage(systemName: "face.smiling")!,
        "スポーツ": UIImage(systemName: "face.smiling")!,
        "健康食品": UIImage(systemName: "face.smiling")!,
        "家電": UIImage(systemName: "face.smiling")!,
        "薬": UIImage(systemName: "face.smiling")!,
        "カウンセリング": UIImage(systemName: "face.smiling")!,
        "病院": UIImage(systemName: "face.smiling")!,
        "マッサージ": UIImage(systemName: "face.smiling")!,
        "その他": UIImage(systemName: "face.smiling")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //交際のサブカテゴリー
    static var CostDatingSubIcon: [String: UIImage] = [
        "交際費": UIImage(systemName: "gift")!,
        "飲み会": UIImage(systemName: "gift")!,
        "プレゼント": UIImage(systemName: "gift")!,
        "冠婚葬祭": UIImage(systemName: "gift")!,
        "食費": UIImage(systemName: "gift")!,
        "交通費": UIImage(systemName: "gift")!,
        "その他": UIImage(systemName: "gift")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //趣味のサブカテゴリー
    static var CostHobbiesSubIcon: [String: UIImage] = [
        "旅行": UIImage(systemName: "sparkles")!,
        "映画": UIImage(systemName: "sparkles")!,
        "ライブ": UIImage(systemName: "sparkles")!,
        "本": UIImage(systemName: "sparkles")!,
        "漫画": UIImage(systemName: "sparkles")!,
        "音楽": UIImage(systemName: "sparkles")!,
        "ゲーム": UIImage(systemName: "sparkles")!,
        "観光食": UIImage(systemName: "sparkles")!,
        "スポーツ": UIImage(systemName: "sparkles")!,
        "服飾": UIImage(systemName: "sparkles")!,
        "その他": UIImage(systemName: "sparkles")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //教養のサブカテゴリー
    static var CostLiberalArtsSubIcon: [String: UIImage] = [
        "書籍": UIImage(systemName: "book")!,
        "新聞": UIImage(systemName: "book")!,
        "雑誌": UIImage(systemName: "book")!,
        "習い事": UIImage(systemName: "book")!,
        "音声": UIImage(systemName: "book")!,
        "動画": UIImage(systemName: "book")!,
        "その他": UIImage(systemName: "book")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //交通のサブカテゴリー
    static var CostTransportationSubIcon: [String: UIImage] = [
        "電車": UIImage(systemName: "figure.walk")!,
        "バス": UIImage(systemName: "figure.walk")!,
        "タクシー": UIImage(systemName: "figure.walk")!,
        "レンタカー": UIImage(systemName: "figure.walk")!,
        "飛行機": UIImage(systemName: "figure.walk")!,
        "夜行バス": UIImage(systemName: "figure.walk")!,
        "地下鉄": UIImage(systemName: "figure.walk")!,
        "モノレール": UIImage(systemName: "figure.walk")!,
        "その他": UIImage(systemName: "figure.walk")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //美容のサブカテゴリー
    static var CostCosmetologySubIcon: [String: UIImage] = [
        "美容院": UIImage(systemName: "scissors")!,
        "化粧品": UIImage(systemName: "scissors")!,
        "エステ": UIImage(systemName: "scissors")!,
        "マッサージ": UIImage(systemName: "scissors")!,
        "ネイル": UIImage(systemName: "scissors")!,
        "その他": UIImage(systemName: "scissors")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //保険のサブカテゴリー
    static var CostInsuranceSubIcon: [String: UIImage] = [
        "生命保険": UIImage(systemName: "heart")!,
        "医療保険": UIImage(systemName: "heart")!,
        "健康保険": UIImage(systemName: "heart")!,
        "国民保険": UIImage(systemName: "heart")!,
        "年金保険": UIImage(systemName: "heart")!,
        "その他": UIImage(systemName: "heart")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //税金のサブカテゴリー
    static var CostTaxSubIcon: [String: UIImage] = [
        "所得税": UIImage(systemName: "doc.text")!,
        "住民税": UIImage(systemName: "doc.text")!,
        "県民税": UIImage(systemName: "doc.text")!,
        "年金": UIImage(systemName: "doc.text")!,
        "その他": UIImage(systemName: "doc.text")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //住宅のサブカテゴリー
    static var CostHousingSubIcon: [String: UIImage] = [
        "家賃": UIImage(systemName: "house")!,
        "住宅ローン": UIImage(systemName: "house")!,
        "家具": UIImage(systemName: "house")!,
        "家電": UIImage(systemName: "house")!,
        "整備": UIImage(systemName: "house")!,
        "その他": UIImage(systemName: "house")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //観光のサブカテゴリー
    static var CostSightseeingSubIcon: [String: UIImage] = [
        "食費": UIImage(systemName: "airplane.departure")!,
        "宿泊代": UIImage(systemName: "airplane.departure")!,
        "交通": UIImage(systemName: "airplane.departure")!,
        "お土産": UIImage(systemName: "airplane.departure")!,
        "日用品": UIImage(systemName: "airplane.departure")!,
        "観光": UIImage(systemName: "airplane.departure")!,
        "その他": UIImage(systemName: "airplane.departure")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //通信のサブカテゴリー
    static var CostNetWorkSubIcon: [String: UIImage] = [
        "携帯": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "Wi-Fi": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "固定電話": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "ネット": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "動画": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "書籍": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "音声": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "その他": UIImage(systemName: "dot.radiowaves.up.forward")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //水道代のサブカテゴリー
    static var CostWaterSubIcon: [String: UIImage] = [
        "水道代": UIImage(systemName: "drop")!,
        "上水道": UIImage(systemName: "drop")!,
        "下水道": UIImage(systemName: "drop")!,
        "その他": UIImage(systemName: "drop")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //ガス代のサブカテゴリー
    static var CostGasSubIcon: [String: UIImage] = [
        "ガス代": UIImage(systemName: "flame")!,
        "その他": UIImage(systemName: "flame")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //電気代のサブカテゴリー
    static var CostElectricitySubIcon: [String: UIImage] = [
        "電気代": UIImage(systemName: "bolt")!,
        "その他": UIImage(systemName: "bolt")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //車のサブカテゴリー
    static var CostCarSubIcon: [String: UIImage] = [
        "ガソリン": UIImage(systemName: "car")!,
        "駐車場": UIImage(systemName: "car")!,
        "道路料金": UIImage(systemName: "car")!,
        "カスタム": UIImage(systemName: "car")!,
        "ローン": UIImage(systemName: "car")!,
        "車検・整備": UIImage(systemName: "car")!,
        "保険": UIImage(systemName: "car")!,
        "その他": UIImage(systemName: "car")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //バイクのサブカテゴリー
    static var CostMotorcycleSubIcon: [String: UIImage] = [
        "ガソリン": UIImage(named: "motorcycle")!,
        "駐車場": UIImage(named: "motorcycle")!,
        "道路料金": UIImage(named: "motorcycle")!,
        "カスタム": UIImage(named: "motorcycle")!,
        "ローン": UIImage(named: "motorcycle")!,
        "車検・整備": UIImage(named: "motorcycle")!,
        "保険": UIImage(named: "motorcycle")!,
        "その他": UIImage(named: "motorcycle")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //医療のサブカテゴリー
    static var CostMedicalSubIcon: [String: UIImage] = [
        "病院": UIImage(systemName: "pills")!,
        "内科": UIImage(systemName: "pills")!,
        "外科": UIImage(systemName: "pills")!,
        "耳鼻科": UIImage(systemName: "pills")!,
        "皮膚科": UIImage(systemName: "pills")!,
        "歯科": UIImage(systemName: "pills")!,
        "心療内科": UIImage(systemName: "pills")!,
        "精神科": UIImage(systemName: "pills")!,
        "薬": UIImage(systemName: "pills")!,
        "その他": UIImage(systemName: "pills")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //ペットのサブカテゴリー
    static var CostPetSubIcon: [String: UIImage] = [
        "医療": UIImage(systemName: "pawprint")!,
        "食費": UIImage(systemName: "pawprint")!,
        "日用品": UIImage(systemName: "pawprint")!,
        "おもちゃ": UIImage(systemName: "pawprint")!,
        "お土産": UIImage(systemName: "pawprint")!,
        "その他": UIImage(systemName: "pawprint")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //設定のサブカテゴリー
    static var CostSettingSubIcon: [String: UIImage] = [
        "食費": UIImage(systemName: "cart")!,
        "日用品": UIImage(systemName: "case")!,
        "服飾": UIImage(systemName: "tshirt")!,
        "健康": UIImage(systemName: "face.smiling")!,
        "交際": UIImage(systemName: "gift")!,
        "趣味": UIImage(systemName: "sparkles")!,
        "教養": UIImage(systemName: "book")!,
        "交通": UIImage(systemName: "figure.walk")!,
        "美容": UIImage(systemName: "scissors")!,
        "保険": UIImage(systemName: "heart")!,
        "税金": UIImage(systemName: "doc.text")!,
        "住宅": UIImage(systemName: "house")!,
        "観光": UIImage(systemName: "airplane.departure")!,
        "通信": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "水道代": UIImage(systemName: "drop")!,
        "ガス代": UIImage(systemName: "flame")!,
        "電気代": UIImage(systemName: "bolt")!,
        "車": UIImage(systemName: "car")!,
        "バイク": UIImage(named: "motorcycle")!,
        "医療": UIImage(systemName: "pills")!,
        "ペット": UIImage(systemName: "pawprint")!,
        "その他": UIImage(systemName: "case")!,
        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]

    //incomeのサブカテゴリーまとめ
    static var IncomeSubIcon = [
        IncomeSalarySubIcon,
        IncomeSideBusinessSubIcon,
        IncomeExtraordinarySubIcon,
        IncomeInvestmentSubIcon,
        IncomePrizeSubIcon,
        IncomeSettingSubIcon
    ]
    
    //incomeの配列
    //給料のサブカテゴリー
    static var IncomeSalarySubIcon: [String: UIImage] = [
        "給料": UIImage(systemName: "yensign.circle")!,
        "ボーナス": UIImage(systemName: "yensign.circle")!,
        "その他": UIImage(systemName: "yensign.circle")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //副業のサブカテゴリー
    static var IncomeSideBusinessSubIcon: [String: UIImage] = [
        "副業": UIImage(systemName: "yensign.circle")!,
        "アルバイト": UIImage(systemName: "yensign.circle")!,
        "配達": UIImage(systemName: "bicycle")!,
        "UberEats": UIImage(systemName: "bicycle")!,
        "出前館": UIImage(systemName: "bicycle")!,
        "AdSense": UIImage(systemName: "g.circle")!,
        "ブログ": UIImage(named: "wordpress")!,
        "AdMob": UIImage(systemName: "g.circle")!,
        "YouTube": UIImage(named: "youtube")!,
        "ポイ活": UIImage(systemName: "p.circle")!,
        "その他": UIImage(systemName: "yensign.circle")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //臨時収入のサブカテゴリー
    static var IncomeExtraordinarySubIcon: [String: UIImage] = [
        "臨時収入": UIImage(systemName: "yensign.circle")!,
        "仕送り": UIImage(systemName: "yensign.circle")!,
        "祝い事": UIImage(systemName: "yensign.circle")!,
        "お年玉": UIImage(systemName: "yensign.circle")!,
        "その他": UIImage(systemName: "yensign.circle")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //投資のサブカテゴリー
    static var IncomeInvestmentSubIcon: [String: UIImage] = [
        "投資": UIImage(systemName: "yensign.circle")!,
        "投資信託": UIImage(systemName: "yensign.circle")!,
        "国債": UIImage(systemName: "yensign.circle")!,
        "その他": UIImage(systemName: "yensign.circle")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //賞のサブカテゴリー
    static var IncomePrizeSubIcon: [String: UIImage] = [
        "賞": UIImage(systemName: "yensign.circle")!,
        "その他": UIImage(systemName: "yensign.circle")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    //設定のサブカテゴリー
    static var IncomeSettingSubIcon: [String: UIImage] = [
        "給料": UIImage(systemName: "yensign.circle")!,
        "副業": UIImage(systemName: "yensign.circle")!,
        "臨時収入": UIImage(systemName: "yensign.circle")!,
        "投資": UIImage(systemName: "yensign.circle")!,
        "賞": UIImage(systemName: "yensign.circle")!,
        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]

    static func sortCostSubCategoryName() -> ([String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String]) {
        
        var costFoodSubIcon: [String] = []
        var costDailyGoodsSubIcon: [String] = []
        var costClothSubIcon: [String] = []
        var costHealthSubIcon: [String] = []
        var costDatingSubIcon: [String] = []
        var costHobbiesSubIcon: [String] = []
        var costLiberalArtsSubIcon: [String] = []
        var costTransportationSubIcon: [String] = []
        var costCosmetologySubIcon: [String] = []
        var costSightseeingSubIcon: [String] = []
        var costCarSubIcon: [String] = []
        var costMotorcycleSubIcon: [String] = []
        var costNetWorkSubIcon: [String] = []
        var costWaterSubIcon: [String] = []
        var costGasSubIcon: [String] = []
        var costElectricitySubIcon: [String] = []
        var costInsuranceSubIcon: [String] = []
        var costTaxSubIcon: [String] = []
        var costHousingSubIcon: [String] = []
        var costMedicalSubIcon: [String] = []
        var costPetSubIcon: [String] = []
        var costSettingSubIcon: [String] = []
        
        //各サブカテゴリータイトルに順番を与える(数値を変えることでカスタマイズ可能)
        //各サブカテゴリーの変数に合わせて中身を入れていく
        CostSubIcon.forEach {
            var countUp = 0
            //辞書のKey値を格納
            let subCostCategoryDataKeyList = Array($0.keys) as [String]
            //カテゴリータイトルと順番を格納する空の辞書型を作る
            var subCostCategoryNameAndIndexDic: [String: Int] = [:]
            //Key値に対応する順番を辞書型のvalueに入れる
            for recieveName in subCostCategoryDataKeyList {
                switch $0 {
                case CostFoodSubIcon:
                    switch recieveName {
                    case "食料品":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "外食":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "朝ご飯":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "昼ご飯":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "晩ご飯":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "カフェ":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "お酒":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "ドンキ":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    case "MaxValue":
                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 9
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 10
                    default:
                        break
                    }
                    countUp = 0
                case CostDailyGoodsSubIcon:
                    switch recieveName {
                    case "消耗品":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "生活雑貨":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "タバコ":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "嗜好品":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "子供関連":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "ペット関連":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "ドンキ":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    default:
                        break
                    }
                    countUp = 1
                case CostClothingSubIcon:
                    switch recieveName {
                    case "上着":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "下着":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "ジャケット":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "Tシャツ":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "アクセサリー":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "クリーニング":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "スボン":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "帽子":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    case "眼鏡":
                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    case "靴":
                        subCostCategoryNameAndIndexDic[recieveName] = 9
                    case "靴下":
                        subCostCategoryNameAndIndexDic[recieveName] = 10
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 11
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 12
                    default:
                        break
                    }
                    countUp = 2
                case CostHealthSubIcon:
                    switch recieveName {
                    case "化粧品":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "スポーツ":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "健康食品":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "家電":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "薬":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "カウンセリング":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "病院":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "マッサージ":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 8
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 9
                    default:
                        break
                    }
                    countUp = 3
                case CostDatingSubIcon:
                    switch recieveName {
                    case "交際費":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "飲み会":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "プレゼント":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "冠婚葬祭":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "食費":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "交通費":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    default:
                        break
                    }
                    countUp = 4
                case CostHobbiesSubIcon:
                    switch recieveName {
                    case "旅行":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "映画":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "ライブ":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "本":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "漫画":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "音楽":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "ゲーム":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "観光食":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    case "スポーツ":
                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    case "服飾":
                        subCostCategoryNameAndIndexDic[recieveName] = 9
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 10
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 11
                    default:
                        break
                    }
                    countUp = 5
                case CostLiberalArtsSubIcon:
                    switch recieveName {
                    case "書籍":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "新聞":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "雑誌":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "習い事":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "音声":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "動画":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    default:
                        break
                    }
                    countUp = 6
                case CostTransportationSubIcon:
                    switch recieveName {
                    case "電車":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "バス":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "タクシー":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "レンタカー":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "飛行機":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "夜行バス":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "地下鉄":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "モノレール":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 8
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 9
                    default:
                        break
                    }
                    countUp = 7
                case CostCosmetologySubIcon:
                    switch recieveName {
                    case "美容院":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "化粧品":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "エステ":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "マッサージ":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "ネイル":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    default:
                        break
                    }
                    countUp = 8
                case CostSightseeingSubIcon:
                    switch recieveName {
                    case "食費":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "宿泊代":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "交通":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "お土産":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "日用品":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "観光":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    default:
                        break
                    }
                    countUp = 9
                case CostCarSubIcon:
                    switch recieveName {
                    case "ガソリン":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "駐車場":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "道路料金":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "カスタム":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "ローン":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "車検・整備":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "保険":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    default:
                        break
                    }
                    countUp = 10
                case CostMotorcycleSubIcon:
                    switch recieveName {
                    case "ガソリン":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "駐車場":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "道路料金":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "カスタム":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "ローン":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "車検・整備":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "保険":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    default:
                        break
                    }
                    countUp = 11
                case CostNetWorkSubIcon:
                    switch recieveName {
                    case "携帯":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "Wi-Fi":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "固定電話":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "ネット":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "動画":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "書籍":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "音声":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    default:
                        break
                    }
                    countUp = 12
                case CostWaterSubIcon:
                    switch recieveName {
                    case "水道代":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    default:
                        break
                    }
                    countUp = 13
                case CostGasSubIcon:
                    switch recieveName {
                    case "ガス代":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    default:
                        break
                    }
                    countUp = 14
                case CostElectricitySubIcon:
                    switch recieveName {
                    case "電気代":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    default:
                        break
                    }
                    countUp = 15
                case CostInsuranceSubIcon:
                    switch recieveName {
                    case "生命保険":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "医療保険":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "健康保険":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "国民保険":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "年金保険":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    default:
                        break
                    }
                    countUp = 16
                case CostTaxSubIcon:
                    switch recieveName {
                    case "所得税":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "住民税":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "県民税":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "年金":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    default:
                        break
                    }
                    countUp = 17
                case CostHousingSubIcon:
                    switch recieveName {
                    case "家賃":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "住宅ローン":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "家具":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "家電":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "整備":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    default:
                        break
                    }
                    countUp = 18
                case CostMedicalSubIcon:
                    switch recieveName {
                    case "病院":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "内科":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "外科":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "耳鼻科":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "皮膚科":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "歯科":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "心療内科":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "精神科":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    case "薬":
                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 9
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 10
                    default:
                        break
                    }
                    countUp = 19
                case CostPetSubIcon:
                    switch recieveName {
                    case "医療":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "食費":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "日用品":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "おもちゃ":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "お土産":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
//                    case "設定":
//                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    default:
                        break
                    }
                    countUp = 20
                case CostSettingSubIcon:
                    switch recieveName {
                    case "食費":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "日用品":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "服飾":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "健康":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "交際":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "趣味":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "教養":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "交通":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    case "美容":
                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    case "保険":
                        subCostCategoryNameAndIndexDic[recieveName] = 9
                    case "税金":
                        subCostCategoryNameAndIndexDic[recieveName] = 10
                    case "住宅":
                        subCostCategoryNameAndIndexDic[recieveName] = 11
                    case "観光":
                        subCostCategoryNameAndIndexDic[recieveName] = 12
                    case "通信":
                        subCostCategoryNameAndIndexDic[recieveName] = 13
                    case "水道代":
                        subCostCategoryNameAndIndexDic[recieveName] = 14
                    case "ガス代":
                        subCostCategoryNameAndIndexDic[recieveName] = 15
                    case "電気代":
                        subCostCategoryNameAndIndexDic[recieveName] = 16
                    case "車":
                        subCostCategoryNameAndIndexDic[recieveName] = 17
                    case "バイク":
                        subCostCategoryNameAndIndexDic[recieveName] = 18
                    case "医療":
                        subCostCategoryNameAndIndexDic[recieveName] = 19
                    case "ペット":
                        subCostCategoryNameAndIndexDic[recieveName] = 20
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 21
                    case "設定":
                        subCostCategoryNameAndIndexDic[recieveName] = 22
                    default:
                        break
                    }
                    countUp = 21
                default:
                    break
                }
            }
            //↑CostSubIcon[食費: 0, 朝ごはん:2, 外食:1]でバラバラになっている
            //subCostCategoryNameAndIndexDic(カテゴリー名と順番の辞書型)から取得したものをvalue値で並び替え
            //CostSubIcon[食費: 0, 外食:1, 朝ごはん:2]で整うが[Dictionary<String, Int>.Element]の型になっている
            let sortDictionary = subCostCategoryNameAndIndexDic.sorted { $0.value < $1.value }
            var dic: [String: Int] = [:]
            var recieveKeys: [String] = []
            //sortDictionaryで並び替えした[keys: "", value: 0]をアップデートして["": 0]の形にする
            sortDictionary.forEach {
                //[String: Int]の型で食費: 0, 外食: 1, 朝ごはん: 2の形にする
                dic.updateValue($0.1, forKey: $0.0)
                //key値に0番目value0番目の要素からアップデートされていくから、アップデートされるたびに用意しておいた配列に代入
                recieveKeys.append(contentsOf: dic.keys)
            }
            
            switch countUp {
            //[食費,外食,朝ごはん...]と[String]にどんどん追加されていく
            case 0:
                costFoodSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 1:
                costDailyGoodsSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 2:
                costClothSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 3:
                costHealthSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 4:
                costDatingSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 5:
                costHobbiesSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 6:
                costLiberalArtsSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 7:
                costTransportationSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 8:
                costCosmetologySubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 9:
                costSightseeingSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 10:
                costCarSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 11:
                costMotorcycleSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 12:
                costNetWorkSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 13:
                costWaterSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 14:
                costGasSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 15:
                costElectricitySubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 16:
                costInsuranceSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 17:
                costTaxSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 18:
                costHousingSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 19:
                costMedicalSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 20:
                costPetSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 21:
                costSettingSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            default:
                break
            }
//            costSubIconMatome[countUp].append(contentsOf: recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] }))
        }
        //[String]で返されるが、superCostCategoryNameAndIndexDicのvalue値で順番が保証されているのでvalue値を変更すればカテゴリーの移動が可能
//        print("costSubIconMatome[0]\(costSubIconMatome[0])")
        return (costFoodSubIcon, costDailyGoodsSubIcon, costClothSubIcon, costHealthSubIcon, costDatingSubIcon, costHobbiesSubIcon, costLiberalArtsSubIcon, costTransportationSubIcon, costCosmetologySubIcon, costSightseeingSubIcon, costCarSubIcon, costMotorcycleSubIcon, costNetWorkSubIcon, costWaterSubIcon, costGasSubIcon, costElectricitySubIcon, costInsuranceSubIcon, costTaxSubIcon, costHousingSubIcon, costMedicalSubIcon, costPetSubIcon, costSettingSubIcon)
    }

    static func sortIncomeSuperCategoryName() -> ([String], [String], [String], [String], [String], [String]) {

        //Income親カテゴリーの名前と順番を格納する変数
        var incomeSalarySubIcon: [String] = []
        var incomeSideBusinessSubIcon: [String] = []
        var incomeExtraordinarySubIcon: [String] = []
        var incomeInvestmentSubIcon: [String] = []
        var incomePrizeSubIcon: [String] = []
        var incomeSettingSubIcon: [String] = []

        lazy var incomeSubIconMatome = [
            incomeSalarySubIcon, incomeSideBusinessSubIcon, incomeExtraordinarySubIcon, incomeInvestmentSubIcon, incomePrizeSubIcon, incomeSettingSubIcon
        ]


        //各サブカテゴリータイトルに順番を与える(数値を変えることでカスタマイズ可能)
        //各サブカテゴリーの変数に合わせて中身を入れていく
        IncomeSubIcon.forEach {
            var countUp = 0
            //辞書のKey値を格納
            let subCostCategoryDataKeyList = Array($0.keys) as [String]
            //カテゴリータイトルと順番を格納する空の辞書型を作る
            var subCostCategoryNameAndIndexDic: [String: Int] = [:]

            //ここで数字を変えることでカスタマイズ可能
            //Key値に対応する順番を辞書型のvalueに入れる
            for recieveName in subCostCategoryDataKeyList {
                switch $0 {
                case IncomeSalarySubIcon:
                    switch recieveName {
                    case "給料":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "ボーナス":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "設定":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    default:
                        break
                    }
                    countUp = 0
                case IncomeSideBusinessSubIcon:
                    switch recieveName {
                    case "副業":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "アルバイト":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "配達":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "UberEats":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "出前館":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "AdSense":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    case "ブログ":
                        subCostCategoryNameAndIndexDic[recieveName] = 6
                    case "AdMob":
                        subCostCategoryNameAndIndexDic[recieveName] = 7
                    case "YouTube":
                        subCostCategoryNameAndIndexDic[recieveName] = 8
                    case "ポイ活":
                        subCostCategoryNameAndIndexDic[recieveName] = 9
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 10
                    case "設定":
                        subCostCategoryNameAndIndexDic[recieveName] = 11
                    default:
                        break
                    }
                    countUp = 1
                case IncomeExtraordinarySubIcon:
                    switch recieveName {
                    case "臨時収入":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "仕送り":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "祝い事":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "お年玉":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "設定":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    default:
                        break
                    }
                    countUp = 2
                case IncomeInvestmentSubIcon:
                    switch recieveName {
                    case "投資":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "投資信託":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "国債":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "設定":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    default:
                        break
                    }
                    countUp = 3
                case IncomePrizeSubIcon:
                    switch recieveName {
                    case "賞":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "その他":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "設定":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    default:
                        break
                    }
                    countUp = 4
                case IncomeSettingSubIcon:
                    switch recieveName {
                    case "給料":
                        subCostCategoryNameAndIndexDic[recieveName] = 0
                    case "副業":
                        subCostCategoryNameAndIndexDic[recieveName] = 1
                    case "臨時収入":
                        subCostCategoryNameAndIndexDic[recieveName] = 2
                    case "投資":
                        subCostCategoryNameAndIndexDic[recieveName] = 3
                    case "賞":
                        subCostCategoryNameAndIndexDic[recieveName] = 4
                    case "設定":
                        subCostCategoryNameAndIndexDic[recieveName] = 5
                    default:
                        break
                    }
                    countUp = 5
                default:
                    break
                }
            }
            //↑IncomeSubIcon[給料: 0, その他:2, ボーナス:1]でバラバラになっている
            //subCostCategoryNameAndIndexDic(カテゴリー名と順番の辞書型)から取得したものをvalue値で並び替え
            //CostSubIcon[給料: 0, ボーナス:1, その他:2]で整うが[Dictionary<String, Int>.Element]の型になっている
            let sortDictionary = subCostCategoryNameAndIndexDic.sorted { $0.value < $1.value }
            var dic: [String: Int] = [:]
            var recieveKeys: [String] = []
            //sortDictionaryで並び替えした[keys: "", value: 0]をアップデートして["": 0]の形にする
            sortDictionary.forEach {
                //[String: Int]の型で「給料: 0, ボーナス: 1, その他: 2」の形にする
                dic.updateValue($0.1, forKey: $0.0)
                //key値に0番目value0番目の要素からアップデートされていくから、アップデートされるたびに用意しておいた配列に代入
                recieveKeys.append(contentsOf: dic.keys)
            }

            switch countUp {
            //[給料,ボーナス,その他...]と[String]にどんどん追加されていく
            case 0:
                incomeSalarySubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 1:
                incomeSideBusinessSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 2:
                incomeExtraordinarySubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 3:
                incomeInvestmentSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 4:
                incomePrizeSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            case 5:
                incomeSettingSubIcon = recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
            default:
                break
            }
        }
        return (incomeSalarySubIcon,incomeSideBusinessSubIcon,incomeExtraordinarySubIcon,incomeInvestmentSubIcon,incomePrizeSubIcon,incomeSettingSubIcon)
    }
}
