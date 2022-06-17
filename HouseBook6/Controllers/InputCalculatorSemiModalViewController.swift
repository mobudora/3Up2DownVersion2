//
//  InputCalculatorSemiModalViewController.swift
//  HouseBook6
//
//  Created by Dora on 2022/04/07.
//

import UIKit

class InputCalculatorSemiModalViewController: UIViewController {
    @IBOutlet weak var caluculatorCollectionView: UICollectionView!
    @IBOutlet weak var caluculatorCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var inputMoneySaveButton: UIButton!
    @IBAction func inputMoneySaveActionButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    enum CalculateStatus {
        case none, plus, minus, multiplication, division
    }

    //電卓で計算するための変数//delegate用の受け取る変数
    private var firstNumber = ""
    private var secondNumber = ""

    var delegate: PassCaluculatorProtocol?
    var calculateStatus: CalculateStatus = .none
    //結果に.0を表示しない、連続で計算できるようにするための確認変数
    var resultString: String?
    let cellId = "cellId"
    
    let numbers = [
        ["AC","8%","10%","÷"],
        ["7","8","9","×"],
        ["4","5","6","ー"],
        ["1","2","3","＋"],
        ["0",".","delete.left","="],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        caluculatorCollectionView.delegate = self
        caluculatorCollectionView.dataSource = self
        caluculatorCollectionView.register(CaluculatorViewCell.self, forCellWithReuseIdentifier: cellId)
        caluculatorCollectionViewHeight.constant = view.frame.size.height / 2 - 40
        inputMoneySaveButton.backgroundColor = .black
        inputMoneySaveButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        inputMoneySaveButton.layer.shadowColor = UIColor.gray.cgColor
        inputMoneySaveButton.layer.shadowOpacity = 0.5
    }
}

extension InputCalculatorSemiModalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numbers.count
    }
    //セルの行の値を表示する
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 15
        let width = (collectionView.frame.width - padding) / 5
        let height = (collectionView.frame.height - padding) / 5
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = caluculatorCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CaluculatorViewCell
        if numbers[indexPath.section][indexPath.row] == "delete.left" {
            let deleteImage = UIImage(systemName: "delete.left")
            let deleteImageView = UIImageView(image: deleteImage)
            deleteImageView.frame.size = cell.sizeThatFits(CGSize(width: cell.frame.size.width / 2, height: cell.frame.size.height / 2))
            deleteImageView.center = CGPoint(x: cell.frame.size.width / 2, y: cell.frame.size.height / 2)
            deleteImageView.tintColor = .black
            deleteImageView.backgroundColor = .white
            deleteImageView.layer.cornerRadius = cell.frame.size.width / 4
            deleteImageView.contentMode = .scaleAspectFit
            cell.numberLabel.isHidden = true
            cell.addSubview(deleteImageView)
            //早期リターン
            return cell
        }
        cell.numberLabel.text = numbers[indexPath.section][indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let clickedNumber = numbers[indexPath.section][indexPath.row]
        print(clickedNumber)
        switch calculateStatus {
        case .none:
            switch clickedNumber {
            case "÷":
                calculateStatus = .division
            case "×":
                calculateStatus = .multiplication
            case "ー":
                calculateStatus = .minus
            case "＋":
                calculateStatus = .plus
            case "AC":
                clear()
            case "8%":
                calcTax(tax: 1.08)
            case "10%":
                calcTax(tax: 1.1)
            case ".":
                if !confirmIncludeDecimalPoint(numberString: firstNumber) {
                    firstNumber += clickedNumber
                    delegate?.recieveData(data: firstNumber)
                }
            case "delete.left":
                if firstNumber.count < 0 { return }
                firstNumber = String(firstNumber.dropLast())
                delegate?.recieveData(data: firstNumber)
            default:
                let intClickedNumber = Int(clickedNumber)
                if intClickedNumber! >= 0 && intClickedNumber! <= 9 {
                    print("clickedNumber:\(clickedNumber)")
                    //先頭に0を持っていたら
                    if firstNumber.hasPrefix("0") {
                        firstNumber = ""
                    }
                    firstNumber += clickedNumber
                    delegate?.recieveData(data: firstNumber)
                }
                break
            }
        case .plus,.minus,.multiplication,.division:
            switch clickedNumber {
            case "0"..."9":
                //先頭に0を持っていたら初期化
                if secondNumber.hasPrefix("0") {
                    secondNumber = ""
                }
                secondNumber += clickedNumber
                delegate?.recieveData(data: secondNumber)
            case "＋":
                let firstNum = Double(firstNumber) ?? 0
                let secondNum = Double(secondNumber) ?? 0

                resultString = String(firstNum + secondNum)

                //端数の.0を消す
                if let result = resultString, result.hasSuffix(".0") {
                    resultString = result.replacingOccurrences(of: ".0", with: "")
                }

                delegate?.recieveData(data: resultString ?? "")

                //続けて計算できるように
                firstNumber = ""
                secondNumber = ""
                firstNumber += resultString ?? ""
                //また.plusへ
                calculateStatus = .plus
            case "ー":
                let firstNum = Double(firstNumber) ?? 0
                let secondNum = Double(secondNumber) ?? 0

                resultString = String(firstNum - secondNum)

                //端数の.0を消す
                if let result = resultString, result.hasSuffix(".0") {
                    resultString = result.replacingOccurrences(of: ".0", with: "")
                }

                delegate?.recieveData(data: resultString ?? "")

                //続けて計算できるように
                firstNumber = ""
                secondNumber = ""
                firstNumber += resultString ?? ""
                //また.plusへ
                calculateStatus = .minus
            case "×":
                let firstNum = Double(firstNumber) ?? 0
                let secondNum = Double(secondNumber) ?? 0

                resultString = String(firstNum * secondNum)

                //端数の.0を消す
                if let result = resultString, result.hasSuffix(".0") {
                    resultString = result.replacingOccurrences(of: ".0", with: "")
                }

                delegate?.recieveData(data: resultString ?? "")

                //続けて計算できるように
                firstNumber = ""
                secondNumber = ""
                firstNumber += resultString ?? ""
                //また.plusへ
                calculateStatus = .multiplication
            case "÷":
                let firstNum = Double(firstNumber) ?? 0
                let secondNum = Double(secondNumber) ?? 0

                resultString = String(firstNum / secondNum)

                //端数の.0を消す
                if let result = resultString, result.hasSuffix(".0") {
                    resultString = result.replacingOccurrences(of: ".0", with: "")
                }

                delegate?.recieveData(data: resultString ?? "")

                //続けて計算できるように
                firstNumber = ""
                secondNumber = ""
                firstNumber += resultString ?? ""
                //また.plusへ
                calculateStatus = .division
            case "AC":
                clear()
            case "=":
                if secondNumber != "" {
                    let firstNum = Double(firstNumber) ?? 0
                    let secondNum = Double(secondNumber) ?? 0

                    //結果に.0を表示しないための確認変数
                    var resultString: String?

                    switch calculateStatus {
                    case .plus:
                        resultString = String(firstNum + secondNum)
                    case .minus:
                        resultString = String(firstNum - secondNum)
                    case .multiplication:
                        resultString = String(firstNum * secondNum)
                    case .division:
                        resultString = String(firstNum / secondNum)
                    default:
                        break
                    }
                    //端数の.0を消す
                    if let result = resultString, result.hasSuffix(".0") {
                        resultString = result.replacingOccurrences(of: ".0", with: "")
                    }

                    delegate?.recieveData(data: resultString ?? "")

                    //続けて計算できるように
                    firstNumber = ""
                    secondNumber = ""
                    firstNumber += resultString ?? ""
                    //また.noneへ
                    calculateStatus = .none
                }
            case ".":
                if !confirmIncludeDecimalPoint(numberString: secondNumber) {
                    secondNumber += clickedNumber
                    delegate?.recieveData(data: secondNumber)
                }
            default:
                break
            }
        }
    }

    private func calcTax(tax: Double) {
        if firstNumber.isEmpty { return }
        firstNumber = String((Double(firstNumber) ?? 0) * tax)
        //端数の.0を消す
        if firstNumber.hasSuffix(".0") {
            firstNumber = firstNumber.replacingOccurrences(of: ".0", with: "")
        }
        delegate?.recieveData(data: firstNumber)
    }

    private func calculation(calcStatus: CalculateStatus) {
        let firstNum = Double(firstNumber) ?? 0
        let secondNum = Double(secondNumber) ?? 0

        switch calcStatus {
        case .plus:
            resultString = String(firstNum + secondNum)
        case .minus:
            resultString = String(firstNum - secondNum)
        case .multiplication:
            resultString = String(firstNum * secondNum)
        case .division:
            resultString = String(firstNum / secondNum)
        case .none:
            break
        }
        //端数の.0を消す
        if let result = resultString, result.hasSuffix(".0") {
            resultString = result.replacingOccurrences(of: ".0", with: "")
        }
        delegate?.recieveData(data: resultString ?? "")

        // 続けて計算できるように
        firstNumber = ""
        secondNumber = ""
        firstNumber += resultString ?? ""

        //また.足し算、引き算、掛け算、割り算へ
        calculateStatus = calcStatus
    }

    func clear() {
        firstNumber = "0"
        secondNumber = ""
        delegate?.recieveData(data: firstNumber)
        calculateStatus = .none
    }
    //小数点を2回打たせないようにするのと、最初に打たせないようにする
    private func confirmIncludeDecimalPoint(numberString: String) -> Bool {
        if numberString.range(of: ".") != nil || numberString.count == 0{
            return true
        } else {
            return false
        }
    }
}

class CaluculatorViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.numberLabel.backgroundColor = .rgb(red: 240, green: 240, blue: 240, alpha: 0.5)
            } else {
                self.numberLabel.backgroundColor = .rgb(red: 255, green: 255, blue: 255, alpha: 1)
            }
        }
    }
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 32)
        label.clipsToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        numberLabel.frame.size = self.frame.size
        addSubview(numberLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
