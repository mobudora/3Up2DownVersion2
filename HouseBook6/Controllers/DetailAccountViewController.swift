//
//  DetailAccountViewController.swift
//  HouseBook6
//
//  Created by Ryu on 2022/06/01.
//

import UIKit
import Firebase

class DetailAccountViewController: UIViewController {

    let db = Firestore.firestore()

    @IBOutlet weak var accountNameLabel: UILabel!

    @IBOutlet weak var accountEmailLabel: UILabel!

    @IBOutlet weak var accountPasswordLabel: UILabel!

    @IBOutlet weak var accountUidLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        getFirestoreUserInfo()
    }
    
    func getFirestoreUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("Firestoreからの読み取りに失敗しました\(err)")
                return
            }
            guard let dic = snapshot?.data() else { return }
            let userInfo = User.init(dic: dic)

            self.accountNameLabel.text = userInfo.name
            self.accountEmailLabel.text = userInfo.email
            self.accountPasswordLabel.text = userInfo.password
            self.accountUidLabel.text = uid
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
