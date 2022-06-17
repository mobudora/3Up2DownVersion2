//
//  PasswordViewController.swift
//  HouseBook
//
//  Created by Dora on 2022/03/29.
//

import UIKit
import Firebase

class PasswordViewController: UIViewController {
    
    let numbers = [
        ["1","2","3"],
        ["4","5","6"],
        ["7","8","9"],
        ["delete.left","0","delete.left"],
    ]
    //登録したユーザーをまとめたものをuserに代入
    var user: User?
    //数字を表示するラベル
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var caluculatorCollectionView: UICollectionView!
    @IBOutlet weak var caluculatorHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        caluculatorCollectionView.delegate = self
        caluculatorCollectionView.dataSource = self
        caluculatorCollectionView.register(PasswordViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        confirmLoggedInUser()
        }
    
    //ログインしている状態か初期登録状態か判断する
    private func confirmLoggedInUser() {
        if Auth.auth().currentUser?.uid == nil || user == nil {
            presentToFirstLoginViewController()
        }
    }
    
    private func presentToFirstLoginViewController() {
        let storyBoard = UIStoryboard(name: "FirstLogin", bundle: nil)
        let firstLoginViewController = storyBoard.instantiateViewController(withIdentifier: "FirstLoginViewController") as! UINavigationController
        firstLoginViewController.modalPresentationStyle = .fullScreen
        self.present(firstLoginViewController, animated: true, completion: nil)
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
extension PasswordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    //セルの行の値を表示する
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    //コレクションビューのヘッダーを表示しない
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //横のマージン10*2個の横マージンがある
        let width = (collectionView.frame.width - 2 * 10) / 3
        let height = collectionView.frame.height / 4
        return .init(width: width, height:  height)
    }
    //横のマージンの設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //縦方向のマージンの設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //cellの情報を変えることができる
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = caluculatorCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PasswordViewCell
        if numbers[indexPath.section][indexPath.row] == "delete.left" {
            let deleteImage = UIImage(systemName: "delete.left")
            let deleteImageView = UIImageView(image: deleteImage)
            deleteImageView.frame.size = cell.sizeThatFits(CGSize(width: cell.frame.size.width / 2, height: cell.frame.size.height / 2))
            deleteImageView.center = CGPoint(x: cell.frame.size.width / 2, y: cell.frame.size.height / 2)
            deleteImageView.tintColor = .white
            cell.numberLabel.isHidden = true
            cell.addSubview(deleteImageView)
        }else {
            cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        }
        
        return cell
    }
    //クリックしたものを認識させる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let clickedNumber = numbers[indexPath.section][indexPath.row]
        print(clickedNumber)
        switch clickedNumber {
        case "0"..."9":
            numberLabel.text = clickedNumber
        case "delete.left":
            numberLabel.text = ""
        default:
            break
        }
    }
}
class PasswordViewCell: UICollectionViewCell {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 32)
        label.clipsToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(numberLabel)
        numberLabel.frame.size = self.frame.size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
