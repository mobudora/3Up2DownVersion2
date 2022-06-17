//
//  welcomeViewController.swift
//  HouseBook
//
//  Created by 新久保龍之介 on 2022/03/029.
//
import Foundation
import UIKit

class WelcomeLoginViewController: UIViewController {

    //インスタンス化
    var userDefaults = UserDefaults.standard

    //カレンダーの日付をとる共有インスタンス
    let calendarViewController = CalendarViewController.calendarViewControllerInstance
    
    let colors = Colors()
    
    var inputNameLabel = ""
    var inputEmailLabel = ""
    var inputDateLabel = ""
    var inputPasswordLabel = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var goTabBarButton: UIButton!
    
    @IBAction func goTabBarButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainStoryboard") as! UITabBarController
        self.present(mainViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //一回きりで保存
        calendarViewController.currentMonth.dateFormat = "M"
        let currentTitleMonth = Int(calendarViewController.currentMonth.string(from: calendarViewController.currentDate)) ?? 0
        //月の数を総合計の時に変わったら付け加えるためにUserDefalutsに保存
        userDefaults.set(currentTitleMonth, forKey: "monthNum")
        

        // Do any additional setup after loading the view.
        goTabBarButtonSetUp()
        nameLabel.text = inputNameLabel
        emailLabel.text = inputEmailLabel
        passwordLabel.text = inputPasswordLabel
        dateLabel.text = inputDateLabel
        
}
    func goTabBarButtonSetUp() {
        goTabBarButton.layer.cornerRadius = 5
        goTabBarButton.layer.shadowColor = UIColor.black.cgColor
        goTabBarButton.layer.shadowOpacity = 0.3
        //影のぼかしの強さ
        goTabBarButton.layer.shadowRadius = 4
        //widthが大きいと右にheightは下に影が伸びる
        goTabBarButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        goTabBarButton.titleLabel?.textAlignment = .center
        view.addSubview(goTabBarButton)
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
