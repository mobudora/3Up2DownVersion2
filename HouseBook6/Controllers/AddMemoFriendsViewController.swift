//
//  AddMemoFriendsViewController.swift
//  HouseBook6
//
//  Created by Ryu on 2022/06/01.
//

import UIKit
import Firebase
import PKHUD

class AddMemoFriendsViewController: UIViewController, UITextFieldDelegate {

    var delegate: UserListTableViewReloadProtocol?

    @IBOutlet weak var userProfileImageButton: UIButton!

    @IBAction func userProfileImageButtonAction(_ sender: Any) {
        HUD.show(.progress, onView: view)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        HUD.hide { (_) in
            HUD.flash(.success, onView: self.view, delay: 1) { (_) in
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
    @IBOutlet weak var nameTextFieled: UITextField!

    @IBOutlet weak var addMemoFriendsToFirestoreButton: UIButton!
    
    @IBAction func addMemoFriendsToFirestoreButtonAction(_ sender: Any) {
        //プロフィールイメージをFireStorageへ保存する
        addUserProfileImageToFirestorage()
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
        userProfileImageButton.layer.cornerRadius = 80
        userProfileImageButton.layer.borderColor = UIColor.rgb(red: 240, green: 240, blue: 240, alpha: 1).cgColor
        userProfileImageButton.layer.borderWidth = 1
        addMemoFriendsToFirestoreButton.isEnabled = false
        addMemoFriendsToFirestoreButton.layer.cornerRadius = 10
        addMemoFriendsToFirestoreButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.1)

        nameTextFieled.delegate = self
    }
    //プロフィールイメージをFireStorageへ保存する
    private func addUserProfileImageToFirestorage() {
        let image = userProfileImageButton.imageView?.image ?? UIImage(named: "LogoHouseWork")
        guard let uploadImage = image?.jpegData(compressionQuality: 0.3) else { return }

        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_image").child(fileName)

        storageRef.putData(uploadImage, metadata: nil) { (metadata, err ) in
            if let err = err {
                print("Firestorageへの情報の保存に失敗しました。\(err)")
                return
            }

            print("Firestorageへの情報の保存に成功しました。")

            storageRef.downloadURL { (url, err) in
                if let err = err {
                    print("Firestorageからのダウンロードに失敗しました。\(err)")
                    return
                }

                print("Firestorageからのダウンロードに成功しました。")
                //Firestorageに登録した画像のURLを取得する
                guard let urlString = url?.absoluteString else { return }
                print("受け取ったurlString: ",urlString)
                //AuthのemailとprofileImageのURLをFirestoreに保存するために渡す。
                self.addUserInfoToFirestore(profileImageUrl: urlString)
            }
        }
    }

    private func addUserInfoToFirestore(profileImageUrl: String){

        guard let name = self.nameTextFieled.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let documentId = randomString(length: 10)

        let chatFriendsData = ["name": name,
                       "profileImageUrl": profileImageUrl
        ] as [String : Any]

        //チャットメモ友達コレクションを作る
        Firestore.firestore().collection("chatFriends\(uid)").document(documentId).setData(chatFriendsData){ (err) in
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

    @objc func showKeyBoard(notification: Notification) {
        //キーボードのフレームサイズ取得
        let keyBoardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        //キーボード左端上部の高さ位置を取得
        guard let keyBoardMinY = keyBoardFrame?.minY else { return }
        //登録ボタンの下のボタン高さ位置を取得
        let registerButtonMaxY = addMemoFriendsToFirestoreButton.frame.maxY
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AddMemoFriendsViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //サイズを大きくしたり小さくしたり編集したイメージを表示させるのに必要
        if let editImage = info[.editedImage] as? UIImage {
            userProfileImageButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            userProfileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        userProfileImageButton.setTitle("", for: .normal)
        userProfileImageButton.imageView?.contentMode = .scaleAspectFill
        userProfileImageButton.contentHorizontalAlignment = .fill
        userProfileImageButton.contentVerticalAlignment = .fill
        userProfileImageButton.clipsToBounds = true

        dismiss(animated: true, completion: nil)
    }
}

extension AddMemoFriendsViewController: UITextViewDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //テキストが空だった時Trueをかえしてくれる。
        //??はテキストの中身がnilだったらtrueを返してね。trueだと登録ボタンを押せなくしている。→//||はどちらかがtrueだったらif文を実行するif emailIsEmpty || passwordIsEmpty || usernameIsEmpty
        let usernameIsEmpty = nameTextFieled.text?.isEmpty ?? true
        //||はどちらかがtrueだったらif文を実行する
        if usernameIsEmpty {
            addMemoFriendsToFirestoreButton.isEnabled = false
            addMemoFriendsToFirestoreButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
        else {
            addMemoFriendsToFirestoreButton.isEnabled = true
            addMemoFriendsToFirestoreButton.backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
        }
        print("textField.text", textField.text)
    }
}
