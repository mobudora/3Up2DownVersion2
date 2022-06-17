//
//  User.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import Foundation
import Firebase

//受け取ったユーザー情報の整理
struct User{
    let name: String
    let createAt: Timestamp!
    let email: String!
    let password: String!
    let profileImageUrl: String
    
    //uidのデータをここで使い回しできるようにする
    var uid: String?
    
    //ここで受け取った情報を上記の変数に代入する
    init(dic: [String: Any]){
        self.name = dic["name"] as! String
        self.createAt = dic["createAt"] as! Timestamp?
        self.email = dic["email"] as! String?
        self.password = dic["password"] as! String?
        self.profileImageUrl = dic["profileImageUrl"] as! String
    }
}
