//
//  FirstLoginViewController.swift
//  HouseBook
//
//  Created by Dora on 2022/03/29.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import PKHUD

class FirstViewController: UIViewController, UITextFieldDelegate {

    let calendarViewController = CalendarViewController.calendarViewControllerInstance
    
    //自動的にnilが初期値として入っているallMoneyLabelにはUILabel!の！は本来はUILabel?でallMoneyを使う際にいちいちallMoneyLabel!と書かなくても良いようにするために書いてある。
    //viewDidLoad()メソッドはクラス：viewControllerクラスのさらに親のクラス：UIViewControllerクラスにも定義されているそれを、ovverrideで以下のコードに上書きする。
    //ここにはメモリにロードされた時に実行したい処理を書く
    //中にはsuper.〇〇がなくても良い場合があるviewDidLoad()は大切だからいる→必要かどうかはクラスのライブラリを参照する。
    @IBOutlet weak var userProfileImageButton: UIButton!
    @IBAction func tappedUserProfileImageButton(_ sender: Any) {
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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    //登録ボタン
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func tappedRegisterButton(_ sender: Any){
        handleAuthToFirebase()
    }
    
    @IBAction func alreadyRegisterButton(_ sender: Any) {
        goAlreadyLoginViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        userProfileImageButton.layer.cornerRadius = 65
        userProfileImageButton.layer.borderColor = UIColor.rgb(red: 240, green: 240, blue: 240, alpha: 1).cgColor
        userProfileImageButton.layer.borderWidth = 1
        registerButton.isEnabled = false
        registerButton.layer.cornerRadius = 10
        registerButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
    }
    
    //トップ画面に戻る
    private func goAlreadyLoginViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //メールアドレスとパスワードをAuthenticationに保存する
    private func handleAuthToFirebase() {
        HUD.show(.progress, onView: view)
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err{
                print("認証情報の保存に失敗しました。\(err)")
                HUD.flash(.error, delay: 1) { _ in
                    HUD.show(.progress)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        HUD.flash(.label("【登録エラー】次のうちのどれかが考えられます。\n1.既に使われているメールアドレスか、誤った形式のアドレスです。\n2.パスワードは6文字以上に設定してください。"), delay: 7)
                    }
                }
                return
            }
            print("認証情報の保存に成功しました。")
            //プロフィール画像をFirestorageへ保存する
            self.addUserProfileImageToFirestorage(email: email)
        }
    }
    
    //プロフィールイメージをFireStorageへ保存する
    private func addUserProfileImageToFirestorage(email: String) {
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
                self.addUserInfoToFirestore(email: email, profileImageUrl: urlString)
            }
        }
    }
    
    //ユーザーの名前、認証情報(メールアドレスとパスワード)と作成日をFIrestoreへ保存する。
    private func addUserInfoToFirestore(email: String, profileImageUrl: String){
        //ユーザーのuidをFirestoredataに反映させるためにAuthから取得する。
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let name = self.usernameTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        
        let docData = ["email": email, "name": name, "createAt": Timestamp(), "password": password, "profileImageUrl": profileImageUrl] as [String : Any]
        
        let costAndIncomeData = [
            "name": name
        ]
        
        let costSubCategoryData = SubCategoryIcon.sortCostSubCategoryName()
        let incomeSubCategoryData = SubCategoryIcon.sortIncomeSuperCategoryName()

        let categoryData = [
            "superCategoryCostName": SuperCategoryIcon.sortCostSuperCategoryName(),
            "superCategoryIncomeName": SuperCategoryIcon.sortIncomeSuperCategoryName(),
            
            "costFoodSubIcon": costSubCategoryData.0,
            "costDailyGoodsSubIcon": costSubCategoryData.1,
            "costClothSubIcon": costSubCategoryData.2,
            "costHealthSubIcon": costSubCategoryData.3,
            "costDatingSubIcon": costSubCategoryData.4,
            "costHobbiesSubIcon": costSubCategoryData.5,
            "costLiberalArtsSubIcon": costSubCategoryData.6,
            "costTransportationSubIcon": costSubCategoryData.7,
            "costCosmetologySubIcon": costSubCategoryData.8,
            "costSightseeingSubIcon": costSubCategoryData.9,
            "costCarSubIcon": costSubCategoryData.10,
            "costMotorcycleSubIcon": costSubCategoryData.11,
            "costNetWorkSubIcon": costSubCategoryData.12,
            "costWaterSubIcon": costSubCategoryData.13,
            "costGasSubIcon": costSubCategoryData.14,
            "costElectricitySubIcon": costSubCategoryData.15,
            "costInsuranceSubIcon": costSubCategoryData.16,
            "costTaxSubIcon": costSubCategoryData.17,
            "costHousingSubIcon": costSubCategoryData.18,
            "costMedicalSubIcon": costSubCategoryData.19,
            "costPetSubIcon": costSubCategoryData.20,
//            "costSettingSubIcon": costSubCategoryData.21,

            "incomeSalarySubIcon": incomeSubCategoryData.0,
            "incomeSideBusinessSubIcon": incomeSubCategoryData.1,
            "incomeExtraordinarySubIcon": incomeSubCategoryData.2,
            "incomeInvestmentSubIcon": incomeSubCategoryData.3,
            "incomePrizeSubIcon": incomeSubCategoryData.4,
//            "incomeSettingSubIcon": incomeSubCategoryData.5
        ] as [String : Any]

        //タイトルの日付を取得
        calendarViewController.currentMonth.dateFormat = "MM"
        calendarViewController.currentYear.dateFormat = "yyyy"
        let year = self.calendarViewController.currentYear.string(from: self.calendarViewController.currentDate)
        
        
        //Authから取得してきたuidをドキュメントにする
        Firestore.firestore().collection("users").document(uid).setData(docData){ [self] (err) in
            if let err = err {
                print("Firestoreへの保存に失敗しました。")
                HUD.hide { (_) in
                    HUD.flash(.error, delay: 1)
                }
                return
            }
            //親カテゴリー収支コレクションを作る
            Firestore.firestore().collection("\(year)superCategoryIncomeAndExpenditure").document(uid).setData(costAndIncomeData){ (err) in
                if let err = err {
                    print("\(year)superCategoryIncomeAndExpenditureコレクションをFirestoreへの保存に失敗しました。")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                    return
                }
            }
            //サブカテゴリー収支コレクションを作る
            Firestore.firestore().collection("\(year)subCategoryIncomeAndExpenditure").document(uid).setData(costAndIncomeData){ (err) in
                if let err = err {
                    print("\(year)subCategoryIncomeAndExpenditureコレクションをFirestoreへの保存に失敗しました。")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                    return
                }
            }
            //カテゴリーコレクションを作る
            Firestore.firestore().collection("categoryData").document(uid).setData(categoryData){ (err) in
                if let err = err {
                    print("categoryコレクションをFirestoreへの保存に失敗しました。")
                    HUD.hide { (_) in
                        HUD.flash(.error, delay: 1)
                    }
                    return
                }
            }

            print("全てのコレクションのFirestoreの保存に成功しました。")
            
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
                    HUD.flash(.success, onView: self.view, delay: 1) { (_) in
                        self.presentToWelocomeViewController(user: user)
                    }
                }
            }
        }
    }
    private func presentToWelocomeViewController(user: User) {
        //ウェルカムページにユーザー情報を渡す。welcomeViewControllerのvar user: User?に渡している
        let storyBoard = UIStoryboard(name: "WelcomeLogin", bundle: nil)
        let welcomeViewController = storyBoard.instantiateViewController(withIdentifier: "welcomeViewController") as! WelcomeLoginViewController
        welcomeViewController.inputNameLabel = user.name + "さんようこそ"
        welcomeViewController.inputEmailLabel = "ログインID: " + user.email
        welcomeViewController.inputPasswordLabel = "ログインパスワード: " + user.password
        let dateString = self.dateFormatterForCreateAt(date: user.createAt.dateValue())
        welcomeViewController.inputDateLabel = "作成日: " + dateString
        //情報の入力がすべて成功できたらwelcomeページへ飛ぶ
        self.present(welcomeViewController, animated: true, completion: nil)
    }
    
    private func dateFormatterForCreateAt(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
    @objc func showKeyBoard(notification: Notification) {
        //キーボードのフレームサイズ取得
        let keyBoardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        //キーボード左端上部の高さ位置を取得
        guard let keyBoardMinY = keyBoardFrame?.minY else { return }
        //登録ボタンの下のボタン高さ位置を取得
        let registerButtonMaxY = registerButton.frame.maxY
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
extension FirstViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension FirstViewController: UITextViewDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        //テキストが空だった時Trueをかえしてくれる。
        //??はテキストの中身がnilだったらtrueを返してね。trueだと登録ボタンを押せなくしている。→//||はどちらかがtrueだったらif文を実行するif emailIsEmpty || passwordIsEmpty || usernameIsEmpty
        let emailIsEmpty = emailTextField.text?.isEmpty ?? true
        let passwordIsEmpty = passwordTextField.text?.isEmpty ?? true
        let usernameIsEmpty = usernameTextField.text?.isEmpty ?? true
        //||はどちらかがtrueだったらif文を実行する
        if emailIsEmpty || passwordIsEmpty || usernameIsEmpty {
            registerButton.isEnabled = false
            registerButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
        else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 1)
        }
        print("textField.text", textField.text)
    }
}

