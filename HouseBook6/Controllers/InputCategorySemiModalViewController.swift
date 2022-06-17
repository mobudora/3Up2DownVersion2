//
//  InputCategorySemiModalViewController.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/09.
//

import UIKit
import SwiftUI
import Firebase

class InputCategorySemiModalViewController: UIViewController {

    //共有用の親カテゴリーインスタンス(どこからでも参照できる)
    static var inputSuperCategoryInstance = InputCategorySemiModalViewController()

    //InputViewControllerの部品を上書きするために用意するインスタンス
    let inputViewControllerOfInputSuperCategory = InputViewController.inputViewControllerInstance
    
    var recieveSuperImageName: UIImage?
    var recieveSuperTitleName: String?
    //delegateへ移譲するためにプロトコルに準拠
    var delegate: PassCategoryProtocol?

    var recieveWhitchIsCollectionCell: Int!

    //初期値として空の配列を入れている
    //ImgaeMaster 配列
    lazy var costAndIncomeDisplayImage: [UIImage] = []
    //TitleMaster 配列
    lazy var costAndIncomeDisplayTitle: [String] = []

    var costDisplayImages: [UIImage] = []

    var costDisplayTitles: [String] = []
    
    var incomeDisplayImages: [UIImage] = []

    var incomeDisplayTitles: [String] = []

    @IBOutlet weak var costAndIncomeSegmentedControl: UISegmentedControl!
    
    @IBAction func costAndIncomeActionSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            costAndIncomeDisplayImage = costDisplayImages
            costAndIncomeDisplayTitle = costDisplayTitles
            //InputSubSemiModalでカテゴリー名の要素順番によって表示するものを変えるため共有インスタンスにも代入
            InputCategorySemiModalViewController.inputSuperCategoryInstance.costAndIncomeDisplayTitle = costDisplayTitles
        case 1:
            costAndIncomeDisplayImage = incomeDisplayImages
            costAndIncomeDisplayTitle = incomeDisplayTitles
            //InputSubSemiModalでカテゴリー名の要素順番によって表示するものを変えるため共有インスタンスにも代入
            InputCategorySemiModalViewController.inputSuperCategoryInstance.costAndIncomeDisplayTitle = incomeDisplayTitles
        default:
            break
        }
        costAndIncomeCategoryCollectionView.reloadData()
    }
    
    @IBOutlet weak var costAndIncomeCategoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Firestoreから親カテゴリーからの情報を取得してカテゴリーに当てはめる
        getSuperCategoryDataFromFirestore()

        costAndIncomeSegmentedControl.selectedSegmentTintColor = UIColor.black
        costAndIncomeSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        costAndIncomeSegmentedControl.layer.borderWidth = 0.1
        costAndIncomeSegmentedControl.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.9)
        
        costAndIncomeCategoryCollectionView.delegate = self
        costAndIncomeCategoryCollectionView.dataSource = self
        costAndIncomeCategoryCollectionView.register(CostCategoryImageViewCell.self, forCellWithReuseIdentifier: "cellId")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("カテゴリー押されたときCost\(inputViewControllerOfInputSuperCategory.costCategoryIndex)")
        print("カテゴリー押されたときIncome\(inputViewControllerOfInputSuperCategory.incomeCategoryIndex)")
        //リセット
        if inputViewControllerOfInputSuperCategory.costCategoryIndex != nil || inputViewControllerOfInputSuperCategory.incomeCategoryIndex != nil {
            inputViewControllerOfInputSuperCategory.costCategoryIndex = nil
            inputViewControllerOfInputSuperCategory.incomeCategoryIndex = nil
        }
        print("リセットされたときCost\(inputViewControllerOfInputSuperCategory.costCategoryIndex)")
        print("リセットされたときIncome\(inputViewControllerOfInputSuperCategory.incomeCategoryIndex)")
    }

    func getSuperCategoryDataFromFirestore() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // FirestoreのDB取得
        let db = Firestore.firestore()
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
                let test = superCategory.superCategorySortedCostNameFromFirestore
                print("親カテゴリー情報の取得に成功しました。\(test)")

                //inocmeDIsplayTitleをcostAndIncomeDisplayTitleに入れたい//
                
                //Firestoreのデータをタイトルに反映
                self.costDisplayTitles = superCategory.superCategorySortedCostNameFromFirestore
                self.incomeDisplayTitles = superCategory.superCategorySortedIncomeNameFromFirestore

                //Key値をvalue値のUIImageに変える
                for recieveData in self.costDisplayTitles {
                    let recievedKey = SuperCategoryIcon.CostIcon[recieveData] ?? UIImage()
                    self.costDisplayImages.append(recievedKey)
                }
                for recieveData in self.incomeDisplayTitles {
                    let recievedKey = SuperCategoryIcon.IncomeIcon[recieveData] ?? UIImage()
                    self.incomeDisplayImages.append(recievedKey)
                }
                
                //収入コレクション・固定費コレクションから来たときに収入segmentを表示するための変数
                self.costAndIncomeSegmentedControl.selectedSegmentIndex = self.recieveWhitchIsCollectionCell ?? 0

                //収入コレクションから来た時、収入ラベルやImageを表示する。
                if self.costAndIncomeSegmentedControl.selectedSegmentIndex == 0 {
                    //costDisplayImageにFirestoreからの親カテゴリー名前を利用してあらかじめ辞書型で作っておいたSuperCategoryIconのCostIcon辞書のvalue値イメージ名前を追加
                    //要はセグメントコントロールのためにもう一回代入している
                    self.costAndIncomeDisplayImage = self.costDisplayImages
                    //costDisplayTitlesにFirestoreからの親カテゴリー名前を追加
                    self.costAndIncomeDisplayTitle = self.costDisplayTitles
                    //InputSubSemiModalでカテゴリー名の要素順番によって表示するものを変えるため共有インスタンスにも代入
                    InputCategorySemiModalViewController.inputSuperCategoryInstance.costAndIncomeDisplayTitle = self.costDisplayTitles
                } else if self.costAndIncomeSegmentedControl.selectedSegmentIndex == 1 { //incomeコレクションから来たとき用
                    self.costAndIncomeDisplayImage = self.incomeDisplayImages
                    self.costAndIncomeDisplayTitle = self.incomeDisplayTitles
                    //InputSubSemiModalでカテゴリー名の要素順番によって表示するものを変えるため共有インスタンスにも代入
                    InputCategorySemiModalViewController.inputSuperCategoryInstance.costAndIncomeDisplayTitle = self.incomeDisplayTitles
                }

                print("親カテゴリーのcostAndIncomeDisplayタイトルに何が入っているか\(self.costAndIncomeDisplayTitle)")

                self.costAndIncomeCategoryCollectionView.reloadData()
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
extension InputCategorySemiModalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return costAndIncomeDisplayTitle.count
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
        let cell = costAndIncomeCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CostCategoryImageViewCell
        cell.imageButton.configuration?.image = costAndIncomeDisplayImage[indexPath.row]
        var container = AttributeContainer()
        cell.imageButton.configuration?.attributedTitle = AttributedString("\( costAndIncomeDisplayTitle[indexPath.row])", attributes: container)
        if cell.imageButton.configuration?.attributedTitle?.characters.count ?? 0 >= 4 {
            container.font = UIFont.systemFont(ofSize: 15)
            cell.imageButton.configuration?.attributedTitle = AttributedString("\( costAndIncomeDisplayTitle[indexPath.row])", attributes: container)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("クリックしたジャンル\(costAndIncomeDisplayTitle)")
        print("元のジャンル\(costAndIncomeDisplayTitle)")

        //sectionがどちらでサブカテゴリーに渡すのか決める(indexはサブカテゴリーを決める変数,whitchIsTransitionは収入と支出のどちらのサブカテゴリーを表示するか決める変数)
        if costDisplayTitles == costAndIncomeDisplayTitle {
            saveToInputViewAndGoSubCategory(index: indexPath.row
                                            , whitchIsTransition: "cost")
        } else if incomeDisplayTitles == costAndIncomeDisplayTitle {
            saveToInputViewAndGoSubCategory(index: indexPath.row
                                            , whitchIsTransition: "income")
        }

        func saveToInputViewAndGoSubCategory(index: Int, whitchIsTransition: String) {

            print("どっちから来た？\(whitchIsTransition)")
            //delegateを通して、InputViewに画像とタイトルを渡す
            recieveSuperImageName = costAndIncomeDisplayImage[indexPath.row]
            recieveSuperTitleName = costAndIncomeDisplayTitle[indexPath.row]
            delegate?.recieveSuperCategoryData(superImage: recieveSuperImageName ?? UIImage(), superTitle: recieveSuperTitleName ?? String())

            //共有インスタンスに値を保持しておく
            inputViewControllerOfInputSuperCategory.inputSuperCategoryIcon.setImage(recieveSuperImageName, for: .normal)
            inputViewControllerOfInputSuperCategory.inputSuperCategoryTitle.text = recieveSuperTitleName

            let storyboard = UIStoryboard(name: "InputSubCategorySemiModal", bundle: nil)
            let nextVc = storyboard.instantiateViewController(withIdentifier: "InputSubCategorySemiModalViewController") as! InputSubCategorySemiModalViewController
            if let sheet = nextVc.sheetPresentationController {
                //どの位置に止まるのか
                sheet.detents = [.medium()]
                //元のViewをいじれるようにする
                sheet.largestUndimmedDetentIdentifier = .medium
            }
            inputViewControllerOfInputSuperCategory.whichIsTheTransition = "InputCategorySemiModalViewから来たよ"
            //indexに対応しているサブカテゴリーを呼び出すためのindex変数
            if whitchIsTransition == "cost" {
                inputViewControllerOfInputSuperCategory.costCategoryIndex = index
            } else if whitchIsTransition == "income" {
                inputViewControllerOfInputSuperCategory.incomeCategoryIndex = index
            }
            present(nextVc, animated: true, completion: nil)
        }
    }

}
class CostCategoryImageViewCell: UICollectionViewCell {
    
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
