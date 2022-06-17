//
//  UserListViewController.swift
//  HouseBook6
//
//  Created by Dora on 2022/03/31.
//

import UIKit
import Firebase
import Nuke

class UserListViewController: UIViewController {

    @IBOutlet weak var plusMemoFriendsToCell: UIBarButtonItem!

    @IBAction func plusMemoFriendsToCellAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "WhitchAddFriends", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "WhitchAddFriendsViewController") as! WhitchAddFriendsViewController
        nextVc.recieveDelegate = self
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    //ユーザーの配列
    private var users = [User]()
    //選択したユーザーを入れる変数
    private var selectedUser: User?
    
    @IBAction func tappedBackNavButton(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    //ナビゲーションバーの右アイテム
    @IBOutlet weak var addMemoFriendButton: UIButton!
    
    @IBOutlet weak var userListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //戻るボタン言葉非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
                )
        
        addMemoFriendButton.layer.cornerRadius = 15
        addMemoFriendButton.isEnabled = false
        addMemoFriendButton.addTarget(self, action: #selector(tappedAddMemoFriendButton), for: .touchUpInside)
        
        userListTableView.delegate = self
        userListTableView.dataSource = self
        getUserInfoFromFirestore()
    }
    
    @objc func tappedAddMemoFriendButton() {
        print("tappedAddMemoButton")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let partnerUid = self.selectedUser?.uid else { return }
        let members = [uid, partnerUid]
        
        let docData = [
            "members": members,
            "latestMessageId": "",
            "createdAt": Timestamp()
        ] as [String : Any]
        Firestore.firestore().collection("chatRoom").addDocument(data: docData) { (err) in
            if let err = err {
                print("ChatRoomの保存に失敗しました。\(err)")
                return
            }
            print("ChatRoomの保存に成功しました。")
            //選択して保存に成功したら自動的にChatRoom.storyboardに戻るようにする
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func getUserInfoFromFirestore() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("chatFriends\(uid)").getDocuments { (snapshots, err) in
            if let err = err {
                print("Firestoreからのuser情報受け取りを失敗しました。\(err)")
                return
            }
            // ???: ドキュメントで回しているから、フィールドで回すようにする
            snapshots?.documents.forEach({ (snapshot) in
                let dic = snapshot.data()
                var user = User.init(dic: dic)
                //ユーザーの個別番号をゲット==ドキュメントのID
                user.uid = snapshot.documentID
                //もしもuidがなかった場合のためにguard let
                guard let uid = Auth.auth().currentUser?.uid else { return }
                //ログインしている自分自身はユーザーリストに表示させたくないので、uidが一致しているか確かめる
                if uid == snapshot.documentID {
                    return
                }
                
                self.users.append(user)
                self.userListTableView.reloadData()
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
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTableView.dequeueReusableCell(withIdentifier: "UserListTableViewCustomCell", for: indexPath) as! UserListTableViewCell
        cell.user = users[indexPath.row]
        return cell
    }
    //選択したユーザーの情報をseledtedUserに格納する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addMemoFriendButton.isEnabled = true
        let userInfo = users[indexPath.row]
        self.selectedUser = userInfo
        //userInfoに代入されているか
        print("userName:", userInfo.name)
    }
}

class UserListTableViewCell: UITableViewCell {
    //Userが増えたらdidSetが行われる
    var user: User? {
        didSet {
            userNameLabel.text = user?.name
            if let url = URL(string: user?.profileImageUrl ?? "") {
                Nuke.loadImage(with: url, into: userImageView)
            }
        }
    }
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.layer.cornerRadius = 25
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension UserListViewController: UserListTableViewReloadProtocol {
    func userListTableViewReload() {
        //viewdidloadで既に取得されているのを削除する
        users = []
        getUserInfoFromFirestore()
    }
}
