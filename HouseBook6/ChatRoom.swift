//
//  ChatRoom.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/01.
//

import Foundation
import Firebase

class  ChatRoom {
    let latestMessageId: String
    let members: [String]
    let createdAt: Timestamp
    
    //Note.storyboardに表示するための最新のメッセージをもつ変数
    var latestMessage: Message?
    //chatRoomの誰なのか判断するためにdocumentIDを受け取る変数を用意
    var documentId: String?
    //ユーザー情報を受け取る変数
    var partnerUser: User?
    
    init(dic: [String: Any]) {
        self.latestMessageId = dic["latestMessageId"] as? String ?? ""
        self.members = dic["members"] as? [String] ?? [String]()
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
