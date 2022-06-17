//
//  AlreadyLoginViewController.swift
//  HouseBook
//
//  Created by 新久保龍之介 on 2022/03/29.
//

import UIKit
import Firebase
import PKHUD

class AlreadyLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func goMainButton(_ sender: Any) {
        HUD.show(.progress, onView: self.view)
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログイン情報の取得に失敗しました。", err)
                HUD.hide { (_) in
                    HUD.flash(.error, delay: 1)
                }
                return
            }
            
            print("ログインに成功しました。")
            //ログインしてる状態であれば取得できる。取得できてなかったらreturnになる。
            guard let uid = Auth.auth().currentUser?.uid else { return }
            //登録したユーザー情報を取得する
            Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
                if let err = err {
                    print("ユーザー情報の取得に失敗しました。\(err)")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                    return
                }
                guard let data = snapshot?.data() else { return }
                //受け取ったユーザー情報の整理
                let user = User.init(dic: data)
                print("ユーザー情報の取得に成功しました。\(user.name)")
                HUD.hide { (_) in
                    //                    HUD.flash(.success, delay: 1)
                    HUD.flash(.success, onView: self.view, delay: 1) { (_) in
                        self.presentToPasswordViewController(user: user)
                    }
                }
            }
        }
    }
    
    private func presentToPasswordViewController(user: User) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainStoryboard") as! UITabBarController
        self.present(mainViewController, animated: true, completion: nil)
        //受け取った情報を次のストーリーボードへ渡す
//        let storyBoard = UIStoryboard(name: "Password", bundle: nil)
//        let passwordViewController = storyBoard.instantiateViewController(identifier: "PasswordStoryboard") as! PasswordViewController
//        passwordViewController.user = user
//        passwordViewController.modalPresentationStyle = .fullScreen
//        self.present(passwordViewController, animated: true, completion: nil)
    }
    
    @IBAction func goFirstLoginButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationObserver()

        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 10
        loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func notificationObserver() {
        //キーボードが出てきた時の通知処理
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard), name: UIResponder.keyboardWillShowNotification, object: nil)
        //キーボードが閉じた時の通知
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyBoard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func showKeyBoard(notification: Notification) {
        //キーボードのフレームサイズ取得
        let keyBoardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        //キーボード左端上部の高さ位置を取得
        guard let keyBoardMinY = keyBoardFrame?.minY else { return }
        //登録ボタンの下のボタン高さ位置を取得
        let registerButtonMaxY = loginButton.frame.maxY
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
}

// MARK: -
extension AlreadyLoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //テキストが空だった時Trueをかえしてくれる。
        //??はテキストの中身がnilだったらtrueを返してね。trueだと登録ボタンを押せなくしている。→//||はどちらかがtrueだったらif文を実行するif emailIsEmpty || passwordIsEmpty || usernameIsEmpty
        let emailIsEmpty = emailTextField.text?.isEmpty ?? true
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? true
        //||はどちらかがtrueだったらif文を実行する
        if emailIsEmpty || passwordIsEmpty {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
        else {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 1)
        }
        print("textField.text", textField.text)
    }
}
