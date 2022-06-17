//
//  SuperCategory.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/04.
//

import Foundation
import Firebase

//受け取ったカテゴリー情報の整理
struct SuperCategoryFromFirestore {

    //Cost親カテゴリーの名前と順番を格納する変数
    let superCategorySortedCostNameFromFirestore: [String]
    //Income親カテゴリーの名前と順番を格納する変数
    let superCategorySortedIncomeNameFromFirestore: [String]

    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any]){
        self.superCategorySortedCostNameFromFirestore = dic["superCategoryCostName"] as! [String]
        self.superCategorySortedIncomeNameFromFirestore = dic["superCategoryIncomeName"] as! [String]
    }
}

struct SuperCategoryIcon {

    static var CostIcon: [String: UIImage] = [
        "食費": UIImage(systemName: "cart")!,
        "日用品": UIImage(systemName: "case")!,
        "服飾": UIImage(systemName: "tshirt")!,
        "健康": UIImage(systemName: "face.smiling")!,
        "交際": UIImage(systemName: "gift")!,
        "趣味": UIImage(systemName: "sparkles")!,
        "教養": UIImage(systemName: "book")!,
        "交通": UIImage(systemName: "figure.walk")!,
        "美容": UIImage(systemName: "scissors")!,
        "観光": UIImage(systemName: "airplane.departure")!,
        "車": UIImage(systemName: "car")!,
        "バイク": UIImage(named: "motorcycle")!,
        "通信": UIImage(systemName: "dot.radiowaves.up.forward")!,
        "水道代": UIImage(systemName: "drop")!,
        "ガス代": UIImage(systemName: "flame")!,
        "電気代": UIImage(systemName: "bolt")!,
        "保険": UIImage(systemName: "heart")!,
        "税金": UIImage(systemName: "doc.text")!,
        "住宅": UIImage(systemName: "house")!,
        "医療": UIImage(systemName: "pills")!,
        "ペット": UIImage(systemName: "pawprint")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    static var IncomeIcon: [String: UIImage] = [
        "給料": UIImage(systemName: "yensign.circle")!,
        "副業": UIImage(systemName: "yensign.circle")!,
        "臨時収入": UIImage(systemName: "yensign.circle")!,
        "投資": UIImage(systemName: "yensign.circle")!,
        "賞": UIImage(systemName: "yensign.circle")!,
//        "設定": UIImage(systemName: "wrench.and.screwdriver")!
    ]
    
    static func sortCostSuperCategoryName() -> [String] {
        //辞書のKey値を格納
        let superCostCategoryDataKeyList = Array(SuperCategoryIcon.CostIcon.keys) as [String]
        //カテゴリータイトルと順番を格納する空の辞書型を作る
        var superCostCategoryNameAndIndexDic: [String: Int] = [:]
        //Key値に対応する順番を辞書型のvalueに入れる
        //ここの順番数字を並び替えることで配置を変えられる
        for recieveName in superCostCategoryDataKeyList {
            switch recieveName {
            case "食費":
                superCostCategoryNameAndIndexDic[recieveName] = 0
            case "日用品":
                superCostCategoryNameAndIndexDic[recieveName] = 1
            case "服飾":
                superCostCategoryNameAndIndexDic[recieveName] = 2
            case "健康":
                superCostCategoryNameAndIndexDic[recieveName] = 3
            case "交際":
                superCostCategoryNameAndIndexDic[recieveName] = 4
            case "趣味":
                superCostCategoryNameAndIndexDic[recieveName] = 5
            case "教養":
                superCostCategoryNameAndIndexDic[recieveName] = 6
            case "交通":
                superCostCategoryNameAndIndexDic[recieveName] = 7
            case "美容":
                superCostCategoryNameAndIndexDic[recieveName] = 8
            case "観光":
                superCostCategoryNameAndIndexDic[recieveName] = 9
            case "車":
                superCostCategoryNameAndIndexDic[recieveName] = 10
            case "バイク":
                superCostCategoryNameAndIndexDic[recieveName] = 11
            case "通信":
                superCostCategoryNameAndIndexDic[recieveName] = 12
            case "水道代":
                superCostCategoryNameAndIndexDic[recieveName] = 13
            case "ガス代":
                superCostCategoryNameAndIndexDic[recieveName] = 14
            case "電気代":
                superCostCategoryNameAndIndexDic[recieveName] = 15
            case "保険":
                superCostCategoryNameAndIndexDic[recieveName] = 16
            case "税金":
                superCostCategoryNameAndIndexDic[recieveName] = 17
            case "住宅":
                superCostCategoryNameAndIndexDic[recieveName] = 18
            case "医療":
                superCostCategoryNameAndIndexDic[recieveName] = 19
            case "ペット":
                superCostCategoryNameAndIndexDic[recieveName] = 20
//            case "設定":
//                superCostCategoryNameAndIndexDic[recieveName] = 21
            default:
                break
            }
        }
        //superCostCategoryNameAndIndexDic(カテゴリー名と順番の辞書型)から取得したものをvalue値で並び替え
        let sortDictionary = superCostCategoryNameAndIndexDic.sorted { $0.value < $1.value }
        var dic: [String: Int] = [:]
        var recieveKeys: [String] = []
        //sortDictionaryで並び替えした[keys: "", value: 0]をアップデートして["": 0]の形にする
        sortDictionary.forEach {
            dic.updateValue($0.1, forKey: $0.0)
            //key値に0番目value0番目の要素からアップデートされていくから、アップデートされるたびに用意しておいた配列に代入
            recieveKeys.append(contentsOf: dic.keys)
        }
        
        //[String]で返されるが、superCostCategoryNameAndIndexDicのvalue値で順番が保証されているのでvalue値を変更すればカテゴリーの移動が可能
        return recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
    }
    static func sortIncomeSuperCategoryName() -> [String] {
        //辞書のKey値を格納
        let superIncomeCategoryDataKeyList = Array(SuperCategoryIcon.IncomeIcon.keys) as [String]
        //空の辞書型を作る
        var superIncomeCategoryNameAndIndexDic: [String: Int] = [:]
        //Key値に対応する順番を辞書型のvalueに入れる
        for recieveName in superIncomeCategoryDataKeyList {
            switch recieveName {
            case "給料":
                superIncomeCategoryNameAndIndexDic[recieveName] = 0
            case "副業":
                superIncomeCategoryNameAndIndexDic[recieveName] = 1
            case "臨時収入":
                superIncomeCategoryNameAndIndexDic[recieveName] = 2
            case "投資":
                superIncomeCategoryNameAndIndexDic[recieveName] = 3
            case "賞":
                superIncomeCategoryNameAndIndexDic[recieveName] = 4
//            case "設定":
//                superIncomeCategoryNameAndIndexDic[recieveName] = 5
            default:
                break
            }
        }
        let sortDictionary = superIncomeCategoryNameAndIndexDic.sorted { $0.value < $1.value }
        var dic: [String: Int] = [:]
        var recieveKeys: [String] = []
        sortDictionary.forEach {
            dic.updateValue($0.1, forKey: $0.0)
            //key値に0番目value0番目の要素からアップデートされていくから、アップデートされるたびに用意しておいた配列に代入
            recieveKeys.append(contentsOf: dic.keys)
        }
        
        return recieveKeys.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
    }
}
