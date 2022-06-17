//
//  AddCollectionViewController.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/19.
//

import UIKit
import SwiftUI
import Firebase

class AddCollectionViewController: UIViewController {

    //CostMonthSuperCategoryをHomeから受け取る変数
    var costMonthSuperCategory: CostMothSuperCategoryFromFireStore?

    let calendarViewController = CalendarViewController.calendarViewControllerInstance

    // FirestoreのDB取得
    let db = Firestore.firestore()

    var delegate: AddCollectionViewCellProtocol?

    //初期値として空の配列を入れている
    var costDisplayImages: [UIImage] = []

    var costDisplayTitles: [String] = []


    @IBOutlet weak var superCategoryCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Firestoreから親カテゴリーからの情報を取得してカテゴリーに当てはめる
        getSuperCategoryDataFromFirestore()

        //IdをcustomCostCategoryCellとして登録
        superCategoryCollectionView.register(CostCategoryCell.self, forCellWithReuseIdentifier: "customCostCategoryCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func getSuperCategoryDataFromFirestore() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // categoryDataコレクションを取得
        db.collection("categoryData").document(uid).getDocument { snapshot, err in
            // エラー発生時
            if let err = err {
                print("FirestoreからのSuperCategoryDataの取得に失敗しました: \(err)")
            } else {
                // コレクション内のドキュメントを取得
                guard let data = snapshot?.data() else { return }
                //受け取った親カテゴリー情報の整理
                let superCategory = SuperCategoryFromFirestore.init(dic: data)

                //Firestoreのデータをタイトルに反映
                self.costDisplayTitles = superCategory.superCategorySortedCostNameFromFirestore

                //Key値をvalue値のUIImageに変える
                for recieveData in self.costDisplayTitles {
                    let recievedKey = SuperCategoryIcon.CostIcon[recieveData] ?? UIImage()
                    self.costDisplayImages.append(recievedKey)
                }

                self.superCategoryCollectionView.reloadData()
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
extension AddCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return costDisplayTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 65) / 5
        return .init(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = superCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "customCostCategoryCell", for: indexPath) as! CostCategoryCell
        cell.imageButton.configuration?.image = costDisplayImages[indexPath.row]
        var container = AttributeContainer()
        cell.imageButton.configuration?.attributedTitle = AttributedString("\( costDisplayTitles[indexPath.row])", attributes: container)
        if cell.imageButton.configuration?.attributedTitle?.characters.count ?? 0 >= 4 {
            container.font = UIFont.systemFont(ofSize: 15)
            cell.imageButton.configuration?.attributedTitle = AttributedString("\( costDisplayTitles[indexPath.row])", attributes: container)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var witchCost: Int!
        print("選択されたときのcostMonthSuperCategory: \(costMonthSuperCategory)")
        switch indexPath.row {
        case 0:
            witchCost = costMonthSuperCategory?.foodMonthSuperCategoryFromFirestore ?? 0
        case 1:
            witchCost = costMonthSuperCategory?.dailyGoodsMonthSuperCategoryFromFirestore ?? 0
        case 2:
            witchCost = costMonthSuperCategory?.clothMonthSuperCategoryFromFirestore ?? 0
        case 3:
            witchCost = costMonthSuperCategory?.healthdMonthSuperCategoryFromFirestore ?? 0
        case 4:
            witchCost = costMonthSuperCategory?.datingMonthSuperCategoryFromFirestore ?? 0
        case 5:
            witchCost = costMonthSuperCategory?.hobbiesMonthSuperCategoryFromFirestore ?? 0
        case 6:
            witchCost = costMonthSuperCategory?.liberalArtsMonthSuperCategoryFromFirestore ?? 0
        case 7:
            witchCost = costMonthSuperCategory?.transportationMonthSuperCategoryFromFirestore ?? 0
        case 8:
            witchCost = costMonthSuperCategory?.cosmetologyMonthSuperCategoryFromFirestore ?? 0
        case 9:
            witchCost = costMonthSuperCategory?.sightseeingMonthSuperCategoryFromFirestore ?? 0
        case 10:
            witchCost = costMonthSuperCategory?.carMonthSuperCategoryFromFirestore ?? 0
        case 11:
            witchCost = costMonthSuperCategory?.motorcycleMonthSuperCategoryFromFirestore ?? 0
        case 12:
            witchCost = costMonthSuperCategory?.netWorkMonthSuperCategoryFromFirestore ?? 0
        case 13:
            witchCost = costMonthSuperCategory?.waterMonthSuperCategoryFromFirestore ?? 0
        case 14:
            witchCost = costMonthSuperCategory?.gasMonthSuperCategoryFromFirestore ?? 0
        case 15:
            witchCost = costMonthSuperCategory?.electricityMonthSuperCategoryFromFirestore ?? 0
        case 16:
            witchCost = costMonthSuperCategory?.insuranceMonthSuperCategoryFromFirestore ?? 0
        case 17:
            witchCost = costMonthSuperCategory?.taxMonthSuperCategoryFromFirestore ?? 0
        case 18:
            witchCost = costMonthSuperCategory?.housingMonthSuperCategoryFromFirestore ?? 0
        case 19:
            witchCost = costMonthSuperCategory?.medicalMonthSuperCategoryFromFirestore ?? 0
        case 20:
            witchCost = costMonthSuperCategory?.petMonthSuperCategoryFromFirestore ?? 0
        default:
            break
        }
        //delegateを通して選択したタイトルと画像を渡す
        delegate?.addCollectionViewCell(collectionTitle: costDisplayTitles[indexPath.row], collectionImage: costDisplayImages[indexPath.row], collectionUsageAmount: witchCost)
        dismiss(animated: true)
    }
}
class CostCategoryCell: UICollectionViewCell {

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.imageButton.backgroundColor = .rgb(red: 240, green: 240, blue: 240, alpha: 0.5)
            } else {
                self.imageButton.backgroundColor = .rgb(red: 255, green: 255, blue: 255, alpha: 1)
            }
        }
    }
    var imageButton: UIButton = {

        let button = UIButton.init(type: .system)
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.buttonSize = .large
        config.baseBackgroundColor = .rgb(red: 117, green: 117, blue: 117, alpha: 0.1)
        config.baseForegroundColor = .black
        config.image = UIImage(systemName: "questionmark.folder")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.imagePlacement = .top
        config.imagePadding = 10
        //最大限丸くする
        config.cornerStyle = .capsule
        button.configuration = config
        button.isUserInteractionEnabled = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageButton.frame.size = self.frame.size
        imageButton.layer.cornerRadius = self.frame.width / 2
        addSubview(imageButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

