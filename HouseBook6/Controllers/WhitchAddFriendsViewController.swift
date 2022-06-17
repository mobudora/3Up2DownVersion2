//
//  WhitchAddFriendsViewController.swift
//  HouseBook6
//
//  Created by Ryu on 2022/06/01.
//

import UIKit

class WhitchAddFriendsViewController: UIViewController {

    //delegateの受け取る
    var recieveDelegate: UserListViewController?

    @IBOutlet weak var goAddFriendsButton: UIButton!

    @IBAction func goAddFriendsButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddFriends", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "AddFriendsViewController") as! AddFriendsViewController
        nextVc.delegate = recieveDelegate
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    @IBOutlet weak var goAddMemoFriendsButton: UIButton!

    @IBAction func goAddMemoFriendsButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddMemoFriends", bundle: nil)
        let nextVc = storyboard.instantiateViewController(withIdentifier: "AddMemoFriendsViewController") as! AddMemoFriendsViewController
        nextVc.delegate = recieveDelegate
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //戻るボタン言葉非表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
                )
        self.navigationController?.navigationBar.tintColor = .black

        setUpButton()
    }
    
    func setUpButton() {
        goAddFriendsButton.layer.cornerRadius = 75
        goAddFriendsButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        goAddFriendsButton.layer.shadowColor = UIColor.gray.cgColor
        goAddFriendsButton.layer.shadowOpacity = 0.6
        goAddFriendsButton.layer.borderWidth = 0.1
        goAddFriendsButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)

        goAddMemoFriendsButton.layer.cornerRadius = 75
        goAddMemoFriendsButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        goAddMemoFriendsButton.layer.shadowColor = UIColor.gray.cgColor
        goAddMemoFriendsButton.layer.shadowOpacity = 0.6
        goAddMemoFriendsButton.layer.borderWidth = 0.1
        goAddMemoFriendsButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
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
