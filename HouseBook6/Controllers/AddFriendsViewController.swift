//
//  AddFriendsViewController.swift
//  HouseBook6
//
//  Created by Ryu on 2022/06/01.
//

import UIKit
import Firebase
import PKHUD


class AddFriendsViewController: UIViewController, UITextFieldDelegate {

    //DBインスタンス化
    let db = Firestore.firestore()

    var delegate: UserListTableViewReloadProtocol?

    @IBOutlet weak var uidTextField: UITextField!

    @IBOutlet weak var addFriendsButton: UIButton!

    @IBAction func addFriendsButtonToFirestore(_ sender: Any) {
        addFriendsToFirestore()
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        notificationObserver()
    }
    
    private func notificationObserver() {
        //キーボードが出てきた時の通知処理
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard), name: UIResponder.keyboardWillShowNotification, object: nil)
        //キーボードが閉じた時の通知
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyBoard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupView() {
        addFriendsButton.isEnabled = false
        addFriendsButton.layer.cornerRadius = 10
        addFriendsButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.1)

        uidTextField.delegate = self
    }
    @objc func showKeyBoard(notification: Notification) {
        //キーボードのフレームサイズ取得
        let keyBoardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        //キーボード左端上部の高さ位置を取得
        guard let keyBoardMinY = keyBoardFrame?.minY else { return }
        //登録ボタンの下のボタン高さ位置を取得
        let registerButtonMaxY = addFriendsButton.frame.maxY
        //キーボードの上部と登録ボタン下位置の差を取得
        let distance = registerButtonMaxY - keyBoardMinY
        //差分だけUIViewを動かす。下に動くからdistanceを−にする→上方向に動く→差分だけだとボタンギリギリだけになるから-20くらいする
        let transform = CGAffineTransform(translationX: 0, y: -distance - 20)
        //UIViewをアニメーションさせる
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = transform
        })

        print("keyBoardFrame : ", keyBoardFrame)
    }
    @objc func hideKeyBoard() {
        //identityでキーボードを閉じたときに元の画面位置に戻す
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    private func addFriendsToFirestore(){

        guard let friendsUid = self.uidTextField.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }

        //uidをもとにnameとprofileImageを取り出す
        db.collection("users").document(friendsUid).getDocument { (snapshot, err) in
            if let err = err {
                print("友達のuid情報をもとにデータの取得をしましたが失敗しました。\(err)")
                return
            }
            print("友達のuidをもとにデータの取得に成功しました。")
            guard let dic = snapshot?.data() else { return }
            let friendsUserData = User.init(dic: dic)

            let friendsName = friendsUserData.name
            let friendsProfileImageUrl = friendsUserData.profileImageUrl

            let chatFriendsData = ["name": friendsName,
                           "profileImageUrl": friendsProfileImageUrl
            ] as [String : Any]

            //チャットメモ友達コレクションを作る
            self.db.collection("chatFriends\(uid)").document(friendsUid).setData(chatFriendsData){ (err) in
                if let err = err {
                    print("chatFriendsコレクションをFirestoreへの保存に失敗しました。\(err)")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                    return
                }
                print("メモお店をFirestoreへのchatFriendsコレクション保存に成功しました。")
                self.delegate?.userListTableViewReload()
            }
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
extension AddFriendsViewController: UITextViewDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //テキストが空だった時Trueをかえしてくれる。
        let uidIsEmpty = uidTextField.text?.isEmpty ?? true
        if uidIsEmpty {
            addFriendsButton.isEnabled = false
            addFriendsButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
        else {
            addFriendsButton.isEnabled = true
            addFriendsButton.backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        }
        print("textField.text", textField.text)
    }
}
