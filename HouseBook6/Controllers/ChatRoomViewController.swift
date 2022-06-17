//
//  ChatRoomViewController.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/29.
//

import UIKit
import Firebase

class ChatRoomViewController: UIViewController {
    
    private var messages = [Message]()
    private let accessoryHeight: CGFloat = 100
    private var safeAreaBottom: CGFloat {
        get {
            self.view.safeAreaInsets.bottom
        }
    }
    
    var chatroom: ChatRoom?
    //今ログインしているユーザー
    var user: User?

    //チャット入力画面のインスタンス化 lazyでselfを使えるようにする
    private lazy var chatInputAccessoryView: ChatInputAccessoryView = {
        let view = ChatInputAccessoryView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: accessoryHeight)
        //chatInputAccessoryViewのdelagateを読み込む
        view.delgate = self
        return view
    }()
    
    @IBOutlet weak var chatRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotification()
        setupChatRoomTableView()
        getMessages()
        
    }
    
    private func setupNotification() {
        //キーボードが出てきたときに通知してくれる機能
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //キーボードが閉じたときに通知してくれる機能
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillSHow")
        guard let userInfo = notification.userInfo else { return }
        
        if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            //キーボードが現れたとき(heightが300くらいの時最初のアクセサリーキーボードの時は移動しない== <= 100)
            if keyboardFrame.height <= accessoryHeight { return }
            print("keyboardFrame", keyboardFrame)
            let top = keyboardFrame.height - safeAreaBottom
            let moveY = -(top - chatRoomTableView.contentOffset.y)
            let contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
            chatRoomTableView.contentInset = contentInset
            chatRoomTableView.scrollIndicatorInsets = contentInset
            //移動
            chatRoomTableView.contentOffset = CGPoint(x: 0, y: moveY)
        }
    }
    @objc func keyboardWillHide() {
        print("keyboardWillHide")
        chatRoomTableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        chatRoomTableView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    private func setupChatRoomTableView() {
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        chatRoomTableView.register(UINib(nibName: "partnerTableViewCell", bundle: nil), forCellReuseIdentifier: "partnerCustomTableViewCell")
        chatRoomTableView.backgroundColor = .rgb(red: 240, green: 240, blue: 240, alpha: 1)
        //キーボードをスクロールすると閉じてくれるようにする
        chatRoomTableView.keyboardDismissMode = .interactive
        //上下反転して上にスクロールしたら終わりにする下にもスクロールできるようにする
        chatRoomTableView.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        chatRoomTableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        chatRoomTableView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //元々あるチャット画面を表示させる機能：inputAccessoryView
    override var inputAccessoryView: UIView? {
        get {
            return chatInputAccessoryView
        }
    }
    //inputAccessoryViewとセットで使う：canBecomeFirstResponder
    override var canBecomeFirstResponder: Bool {
        return true
    }
//chatRoomが表示されたときにメッセージを表示する
    private func getMessages() {
        guard let chatroomDocId = chatroom?.documentId else { return }
        
        Firestore.firestore().collection("chatRoom").document(chatroomDocId).collection("messages").addSnapshotListener { (snapshots, err) in
            if let err = err {
                print("メッセージの取得に失敗しました。\(err)")
                return
            }
            snapshots?.documentChanges.forEach({ (documentChange) in
                switch documentChange.type {
                case .added:
                    let dic = documentChange.document.data()
                    let message = Message(dic: dic)
                    message.partnerUser = self.chatroom?.partnerUser
                    
                    self.messages.append(message)
                    //時系列順に並び替え
                    self.messages.sort { (m1, m2) -> Bool in
                        let m1Date = m1.createdAt.dateValue()
                        let m2Date = m2.createdAt.dateValue()
                        return m1Date > m2Date
                    }
                    
                    self.chatRoomTableView.reloadData()
                    //表示をメッセージの数の-1個目==最後の行(0から始まるから)
//                    self.chatRoomTableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
                    print("message dic:", dic)
                case .modified, .removed:
                print("nothing to do")
                }
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//受け取ったテキストをdelegateで受け取る
extension ChatRoomViewController: ChatInputAccessoryViewDelegate {
    func tappedSendButton(text: String) {
        addMessageToFirestore(text: text)
    }
    
    private func addMessageToFirestore(text: String) {
        guard let chatroomDocId = chatroom?.documentId else { return }
        guard let name = user?.name else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
//        入力欄を空にする
        chatInputAccessoryView.removeText()
        let messagesId = randomString(length: 20)
        
        let docData = [
            "name": name,
            "createdAt": Timestamp(),
            "uid": uid,
            "message": text
        ] as [String : Any]
        
        //FirestoreのコレクションchatRoomの個別に割り当てられたuidのdocumentの中にmessageコレクションに情報を渡して作る
        Firestore.firestore().collection("chatRoom").document(chatroomDocId).collection("messages").document(messagesId).setData(docData) { (err) in
            if let err = err {
                print("メッセージの保存に失敗しました。\(err)")
                return
            }
            
            let latestMessageData = [
                "latestMessageId": messagesId
            ]
            
            //最後のメッセージをFirestoreのchatRoomコレクションのchatroomDocIdドキュメント==chatRoomのドキュメントIDの中のDataをアップデートする
            Firestore.firestore().collection("chatRoom").document(chatroomDocId).updateData(latestMessageData) { (err) in
                if let err = err {
                    print("最新メッセージの保存に失敗しました。\(err)")
                    return
                }
            }
            print("メッセージの保存に成功しました。")
        }
    }
    //FirestoreのchatRoomコレクションのchatroomDocIdドキュメント==chatRoomのドキュメントIDのmessagesコレクションの中のドキュメントIDをランダムでこちら側で作る関数
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
extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        chatRoomTableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: "partnerCustomTableViewCell", for: indexPath) as! partnerTableViewCell
        cell.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        cell.messageText = messages[indexPath.row]
        return cell
    }
    
    
}
