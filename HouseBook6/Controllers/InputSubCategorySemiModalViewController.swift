//
//  InputSubCategorySemiModalViewController.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/10.
//

import UIKit
import Firebase

class InputSubCategorySemiModalViewController: UIViewController {
    
    //共有のInputViewControllerのインスタンス今回は未分類かどうか判断するために使う//InputViewControllerの部品を上書きするために用意するインスタンス
    let inputViewControllerOfInputSubCategory = InputViewController.inputViewControllerInstance
    //InputSuperCategoryのインスタンスを上書きする
    let inputSuperCategoryInstance = InputCategorySemiModalViewController.inputSuperCategoryInstance
    
    var recieveSubImageName: UIImage?
    var recieveSubTitleName: String?
    var delegate: PassCategoryProtocol?
    
    //初期値として空の配列を入れている
    //支出の変数タイトル
    var subCostDisplayTitle: [String] = []
    //収入の変数タイトル
    var subIncomeDisplayTitle: [String] = []
    
    //CostのUIImageを表示するために空の配列を用意
    var subCostDisplayImages: [UIImage] = []
    //CostのUIImageを表示するために空の配列を用意
    var subIncomeDisplayImages: [UIImage] = []
    
    var subCategoryCount: Int!
    
    @IBAction func dismissToSuperCategory(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var superCategoryTitle: UILabel!
    
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //サブカテゴリー上部の親カテゴリーの名前を表示
        superCategoryTitle.text = inputViewControllerOfInputSubCategory.inputSuperCategoryTitle.text

        //支出カテゴリーから来たとき
        if inputViewControllerOfInputSubCategory.costCategoryIndex != nil {
            //Firestoreから支出サブカテゴリーの情報を取得する
            getSubCategoryDataFromFirestore(whitchSuperCategory: inputViewControllerOfInputSubCategory.costCategoryIndex)
        } else if inputViewControllerOfInputSubCategory.incomeCategoryIndex != nil {
            //収入カテゴリーから来たとき
            //Firestoreから収入サブカテゴリーの情報を取得する
            getSubCategoryDataFromFirestore(whitchSuperCategory: inputViewControllerOfInputSubCategory.incomeCategoryIndex)
        }

        subCategoryCollectionView.delegate = self
        subCategoryCollectionView.dataSource = self
        subCategoryCollectionView.register(SubCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func getSubCategoryDataFromFirestore(whitchSuperCategory: Int) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // FirestoreのDB取得
        let db = Firestore.firestore()
        // categoryDataコレクションを取得
        db.collection("categoryData").document(uid).getDocument { snapshot, err in
            // エラー発生時
            if let err = err {
                print("FirestoreからのSubCategoryDataの取得に失敗しました: \(err)")
            } else {
                // コレクション内のドキュメントを取得
                guard let data = snapshot?.data() else { return }
                //受け取った親カテゴリー情報の整理
                let subCategory = SubCategoryFromFirestore.init(dic: data)

                //支出カテゴリーから来たとき
                if self.inputViewControllerOfInputSubCategory.costCategoryIndex != nil {
                    switch whitchSuperCategory {
                    case 0:
                        //Firestoreのcostの配列データをタイトルに反映
                        self.subCostDisplayTitle = subCategory.costFoodSubIconNameFromFirestore
                    case 1:
                        self.subCostDisplayTitle = subCategory.costDailyGoodsSubIconNameFromFirestore
                    case 2:
                        self.subCostDisplayTitle = subCategory.costClothSubIconNameFromFirestore
                    case 3:
                        self.subCostDisplayTitle = subCategory.costHealthSubIconNameFromFirestore
                    case 4:
                        self.subCostDisplayTitle = subCategory.costDatingSubIconNameFromFirestore
                    case 5:
                        self.subCostDisplayTitle = subCategory.costHobbiesSubIconNameFromFirestore
                    case 6:
                        self.subCostDisplayTitle = subCategory.costLiberalArtsSubIconNameFromFirestore
                    case 7:
                        self.subCostDisplayTitle = subCategory.costTransportationSubIconNameFromFirestore
                    case 8:
                        self.subCostDisplayTitle = subCategory.costCosmetologySubIconNameFromFirestore
                    case 9:
                        self.subCostDisplayTitle = subCategory.costSightseeingSubIconNameFromFirestore
                    case 10:
                        self.subCostDisplayTitle = subCategory.costCarSubIconNameFromFirestore
                    case 11:
                        self.subCostDisplayTitle = subCategory.costMotorcycleSubIconNameFromFirestore
                    case 12:
                        self.subCostDisplayTitle = subCategory.costNetWorkSubIconNameFromFirestore
                    case 13:
                        self.subCostDisplayTitle = subCategory.costWaterSubIconNameFromFirestore
                    case 14:
                        self.subCostDisplayTitle = subCategory.costGasSubIconNameFromFirestore
                    case 15:
                        self.subCostDisplayTitle = subCategory.costElectricitySubIconNameFromFirestore
                    case 16:
                        self.subCostDisplayTitle = subCategory.costInsuranceSubIconNameFromFirestore
                    case 17:
                        self.subCostDisplayTitle = subCategory.costTaxSubIconNameFromFirestore
                    case 18:
                        self.subCostDisplayTitle = subCategory.costHousingSubIconNameFromFirestore
                    case 19:
                        self.subCostDisplayTitle = subCategory.costMedicalSubIconNameFromFirestore
                    case 20:
                        self.subCostDisplayTitle = subCategory.costPetSubIconNameFromFirestore
//                    case 21:
//                        self.subCostDisplayTitle = subCategory.costSettingSubIconNameFromFirestore
                    default:
                        break
                    }
                    self.subCategoryCount = self.subCostDisplayTitle.count
                } else if self.inputViewControllerOfInputSubCategory.incomeCategoryIndex != nil { //収入カテゴリーから来たとき
                    switch whitchSuperCategory {
                    case 0:
                        //FirestoreのIncomeの配列データをタイトルに反映
                        self.subIncomeDisplayTitle = subCategory.incomeSalarySubIconNameFromFirestore
                    case 1:
                        self.subIncomeDisplayTitle = subCategory.incomeSideBusinessSubIconNameFromFirestore
                    case 2:
                        self.subIncomeDisplayTitle = subCategory.incomeExtraordinarySubIconNameFromFirestore
                    case 3:
                        self.subIncomeDisplayTitle = subCategory.incomeInvestmentSubIconNameFromFirestore
                    case 4:
                        self.subIncomeDisplayTitle = subCategory.incomePrizeSubIconNameFromFirestore
//                    case 5:
//                        self.subIncomeDisplayTitle = subCategory.incomeSettingSubIconNameFromFirestore
                    default:
                        break
                    }
                    self.subCategoryCount = self.subIncomeDisplayTitle.count
                }
                self.subCategoryCollectionView.reloadData()
            }
        }
    }
}

// MARK: - extensionCollectionView
extension InputSubCategorySemiModalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //配列は1つしかないから1
        return 1
    }

    //SuperCategoryから受け取ったcategoryIndex順に並んでいるサブカテゴリーを呼び出す。呼応している。コレクションの数を決める
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        //支出カテゴリーから来た時
        print("支出カテゴリーから来た時の要素番号\(inputViewControllerOfInputSubCategory.costCategoryIndex)")
        //受け取った親カテゴリーの要素位置とサブカテゴリーの配列の要素番号が一致しているのでそのサブカテゴリーの配列要素を返す。例)食費: 0→サブカテ食費: 0
        print("サブカテの要素数\(subCategoryCount)")
        //収入カテゴリーから来たとき
        print("収入カテゴリーから来た時の要素番号\(inputViewControllerOfInputSubCategory.incomeCategoryIndex)")
        return subCategoryCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 65) / 5
        return .init(width: width, height: width)
    }

    //コレクションのデザインを決める
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SubCategoryCollectionViewCell

        print("InputViewの親カテゴリータイトル\(inputViewControllerOfInputSubCategory.inputSuperCategoryTitle.text)")
        //親カテゴリーを選択されたときifの中に入る
        if inputViewControllerOfInputSubCategory.inputSuperCategoryTitle.text != "未分類" {
            //文字サイズが4文字以上を超えたらButtonの文字サイズを小さくするための変数
            var container = AttributeContainer()
            print("親支出カテゴリーの何番目の要素番号から来たか\(inputViewControllerOfInputSubCategory.costCategoryIndex)")
            print("親収入カテゴリーの何番目の要素番号から来たか\(inputViewControllerOfInputSubCategory.incomeCategoryIndex)")
            //costサブカテゴリーが表示される
            if inputViewControllerOfInputSubCategory.costCategoryIndex != nil {
                // 配列の最初に一致したインデックス番号が返される
                //親カテゴリーの配列要素を取得//親カテゴリーを選択して変化したinputViewControllerOfInputSubCategory(InputViewControllerに映っている)で受け取ったタイトルを探してinputCategorySemiModalViewControllerOfInputSubCategoryのcostDisplayTitles(costのタイトル名前まとめ配列)の要素番号を返す
                if let firstIndex = inputSuperCategoryInstance.costAndIncomeDisplayTitle.firstIndex(where: {$0 == inputViewControllerOfInputSubCategory.inputSuperCategoryTitle.text}) {
                    //各配列の要素を取り出す
                    //UIImageを返す
                    //Key値をvalue値のUIImageに変える
                    //recieveDataで1つづつ受け取って、要素を格納していく
                    //SubCategoryIcon.CostSubIcon[firstIndex][String(recieveData)]はvalue値を表す
                    for recieveData in self.subCostDisplayTitle {
                        let recievedKey = SubCategoryIcon.CostSubIcon[firstIndex][String(recieveData)] ?? UIImage()
                        self.subCostDisplayImages.append(recievedKey)
                    }
                    print("支出インデックス番号: \(firstIndex)")
                    cell.imageButton.configuration?.image = subCostDisplayImages[indexPath.row]
                    //文字サイズが4文字以上を超えたらButtonの文字サイズを小さくする
                    //一回入れて文字数を測る
                    cell.imageButton.configuration?.attributedTitle = AttributedString("\(self.subCostDisplayTitle[indexPath.row])", attributes: container)
                    if cell.imageButton.configuration?.attributedTitle?.characters.count ?? 0 >= 4 {
                        container.font = UIFont.systemFont(ofSize: 12)
                        cell.imageButton.configuration?.attributedTitle = AttributedString("\(self.subCostDisplayTitle[indexPath.row])", attributes: container)
                    }
                }
            } else if inputViewControllerOfInputSubCategory.incomeCategoryIndex != nil { //incomeサブカテゴリーが表示される
                print("収入サブカテゴリータイトル\(subIncomeDisplayTitle)")
                print("親カテゴリーのタイトルは何が入っているのか\(inputSuperCategoryInstance.costAndIncomeDisplayTitle)")
                if let firstIndex = inputSuperCategoryInstance.costAndIncomeDisplayTitle.firstIndex(where: {$0 == inputViewControllerOfInputSubCategory.inputSuperCategoryTitle.text}) {

                    for recieveData in self.subIncomeDisplayTitle {
                        let recievedKey = SubCategoryIcon.IncomeSubIcon[firstIndex][String(recieveData)] ?? UIImage()
                        self.subIncomeDisplayImages.append(recievedKey)
                    }
                    print("支出インデックス番号: \(firstIndex)")
                    cell.imageButton.configuration?.image = subIncomeDisplayImages[indexPath.row]

                    cell.imageButton.configuration?.attributedTitle = AttributedString("\(self.subIncomeDisplayTitle[indexPath.row])", attributes: container)
                    if cell.imageButton.configuration?.attributedTitle?.characters.count ?? 0 >= 4 {
                        container.font = UIFont.systemFont(ofSize: 12)
                        cell.imageButton.configuration?.attributedTitle = AttributedString("\(self.subIncomeDisplayTitle[indexPath.row])", attributes: container)
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        //delegateの処理と戻る処理を行う
        subCategoryDataToInputView()
        
        func subCategoryDataToInputView() {
            if inputViewControllerOfInputSubCategory.costCategoryIndex != nil {
                recieveSubImageName = self.subCostDisplayImages[indexPath.row]
                recieveSubTitleName = self.subCostDisplayTitle[indexPath.row]
            } else if inputViewControllerOfInputSubCategory.incomeCategoryIndex != nil {
                recieveSubImageName = self.subIncomeDisplayImages[indexPath.row]
                recieveSubTitleName = self.subIncomeDisplayTitle[indexPath.row]
            }

            if inputViewControllerOfInputSubCategory.whichIsTheTransition == "InputViewから来たよ" {
                let vc = self.presentingViewController as! InputViewController
                vc.inputSubCategoryTitle.text = recieveSubTitleName
                vc.inputSubCategoryIcon.setImage(recieveSubImageName, for: .normal)
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            } else if inputViewControllerOfInputSubCategory.whichIsTheTransition == "InputCategorySemiModalViewから来たよ" {
                let vc = self.presentingViewController?.presentingViewController as! InputViewController
                vc.inputSubCategoryTitle.text = recieveSubTitleName
                vc.inputSubCategoryIcon.setImage(recieveSubImageName, for: .normal)
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
class SubCategoryCollectionViewCell: UICollectionViewCell {
    
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
        config.title = "食費"
        config.titleAlignment = .center
        config.buttonSize = .mini
        config.baseBackgroundColor = .rgb(red: 117, green: 117, blue: 117, alpha: 0.1)
        config.baseForegroundColor = .black
        config.image = UIImage.init(systemName: "questionmark.folder", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.imagePlacement = .top
        config.imagePadding = 10
        config.cornerStyle = .capsule
        button.configuration = config
        button.isUserInteractionEnabled = false
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
