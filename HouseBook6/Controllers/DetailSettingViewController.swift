//
//  DetailSettingViewController.swift
//  HouseBook
//
//  Created by Dora on 2022/03/10.
//

import UIKit
import Firebase
import StoreKit

class DetailSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    
    let viewSettingTextCell = ["テーマ","総資産表示"]
    let viewSettingImgCell = ["paintpalette","cylinder.split.1x2"]
    let generalSettingTextCell = ["ログアウト","アカウント","バックアップと復元","記入通知お知らせ時間","カテゴリ追加"]
    let generalSettingImgCell = ["arrow.uturn.left.circle","lock.shield","cloud","bell","plus.rectangle.on.rectangle"]
    let aboutAppTextCell = ["家計簿のメリット","アプリの使い方","開発者おすすめの貯金術","これからの開発について"]
    let aboutAppImgCell = ["arrow.triangle.branch","book","sparkles","hammer"]
    let contactTextCell = ["ご意見・ご要望","レビューする","開発者Twitter","利用規約","Version"]
    let contactImgCell = ["envelope","star","person.circle","doc.text","info"]
    let sectionTitles = ["見た目","一般設定","アプリについて","お問合せ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .black
        
        //cellの要素の数
        let cellNumber = viewSettingTextCell.count + generalSettingTextCell.count + aboutAppTextCell.count + contactTextCell.count + sectionTitles.count
        //セル分の高さをtableviewのサイズ(heightConstant)にする。20個(19+searchbar(1))ある今回は
        heightConstant.constant = CGFloat(44 * (cellNumber + 1))
        //セルを登録
        TableView.register(UINib(nibName: "DetailSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "generalCell")
        TableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "contactCell")
    }
    
    //Cellの数設定今回は累計16個・1セクションに入れるCellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
          return viewSettingTextCell.count
        }else if section == 1 {
          return generalSettingTextCell.count
        }else if section == 2 {
          return aboutAppTextCell.count
        }else if section == 3 {
          return contactTextCell.count
        }else {
          return 0
        }
      }
    //セルに代入する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 3:
            let contactCell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
            contactCell.contactCellImg.image = UIImage(systemName: contactImgCell[indexPath.row])
            contactCell.contactCellLabel.text = contactTextCell[indexPath.row]
            return contactCell
        default:
            //storyboardで定義したidentifierの名前と関連付けする。
            let generalcell = tableView.dequeueReusableCell(withIdentifier: "generalCell", for: indexPath) as! DetailSettingTableViewCell
            if indexPath.section == 0 {
              generalcell.generalImg.image = UIImage(systemName: viewSettingImgCell[indexPath.row])
              generalcell.generalLabel.text = viewSettingTextCell[indexPath.row]
              generalcell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }else if indexPath.section == 1 {
              generalcell.generalImg.image = UIImage(systemName: generalSettingImgCell[indexPath.row])
              generalcell.generalLabel.text = generalSettingTextCell[indexPath.row]
              generalcell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }else if indexPath.section == 2 {
              generalcell.generalImg.image = UIImage(systemName: aboutAppImgCell[indexPath.row])
              generalcell.generalLabel.text = aboutAppTextCell[indexPath.row]
              generalcell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }
            return generalcell
        }
      }
    //Cellの見出し設定
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
      }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
      }
    //セルタップ時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = [indexPath.row]
        switch indexPath.section {
        case 0:
            print("見た目だよ\(cell)")
            if indexPath.row == 0 {
                print("テーマの設定をここに記入")
                goDetailTextViewController()
            }
            else if indexPath.row == 1 {
                print("総資産表示の設定をここに記入")
                goDetailTextViewController()
            }
        case 1:
            print("一般だよ\(cell)")
            if indexPath.row == 0 {
                print("ログアウトの設定をここに記入")
                do {
                    try Auth.auth().signOut()
                    performSegue(withIdentifier: "goTopViewStoryboard", sender: self)
                } catch (let err) {
                    print("ログアウトに失敗しました。\(err)")
                }
            }
            else if indexPath.row == 1 {
                print("アカウントの設定をここに記入")
                goDetailAccountViewController()
            }
            else if indexPath.row == 2 {
                print("バックアップと復元の設定をここに記入")
                goDetailTextViewController()
            }
            else if indexPath.row == 3 {
                print("記入通知お知らせ時間の設定をここに記入")
                goDetailTextViewController()
            }
            else if indexPath.row == 4 {
                print("カテゴリ追加の設定をここに記入")
                goDetailTextViewController()
            }
        case 2:
            print("アプリについてだよ\(cell)")
            if indexPath.row == 0 {
                print("家計簿のメリットの設定をここに記入")
                goDetailAboutAppViewController()
            }
            else if indexPath.row == 1 {
                print("アプリの使い方の設定をここに記入")
                goDetailHowToUseViewController()
            }
            else if indexPath.row == 2 {
                print("開発者おすすめの貯金術をここに記入")
                goDetailRecommendViewController()
            }
            else if indexPath.row == 3 {
                print("これからの開発についてをここに記入")
                goDetailFutureViewController()
            }
        case 3:
            print("お問合せだよ\(cell)")
            if indexPath.row == 0 {
                print("ご意見・ご要望の設定をここに記入")
                // 外部ブラウザ（Safari）で開く
                goURL(url: "https://swiftblog.tokyo/contactform/")
            }
            else if indexPath.row == 1 {
                print("レビューするの設定をここに記入")
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
            else if indexPath.row == 2 {
                print("開発者Twitterの設定をここに記入")
                goURL(url: "https://twitter.com/mobudora")
            }
            else if indexPath.row == 3 {
                print("利用規約をここに記入")
                goURL(url: "https://swiftblog.tokyo/termsofuse/")
            }
            else if indexPath.row == 4 {
                print("Versionをここに記入")
                goURL(url: "https://swiftblog.tokyo/3up2down-version/")
            }
        default:
            break
        }
    }
    func goURL(url: String) {
        let url = NSURL(string: url)
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    func goDetailTextViewController() {
        let storyboard = UIStoryboard(name: "DetailText", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "DetailTextViewController") as! DetailTextViewController
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    func goDetailAccountViewController() {
        let storyboard = UIStoryboard(name: "DetailAccount", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "DetailAccountViewController") as! DetailAccountViewController
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    func goDetailAboutAppViewController() {
        let storyboard = UIStoryboard(name: "DetailAboutApp", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "DetailAboutAppViewController") as! DetailAboutAppViewController
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    func goDetailHowToUseViewController() {
        let storyboard = UIStoryboard(name: "DetailHowToUse", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "DetailHowToUseViewController") as! DetailHowToUseViewController
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    func goDetailRecommendViewController() {
        let storyboard = UIStoryboard(name: "DetailRecommend", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "DetailRecommendViewController") as! DetailRecommendViewController
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    func goDetailFutureViewController() {
        let storyboard = UIStoryboard(name: "DetailFuture", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "DetailFutureViewController") as! DetailFutureViewController
        self.navigationController?.pushViewController(nextVc, animated: true)
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
