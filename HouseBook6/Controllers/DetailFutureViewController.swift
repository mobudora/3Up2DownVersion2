//
//  DetailFutureViewController.swift
//  HouseBook6
//
//  Created by Ryu on 2022/05/31.
//

import UIKit
import StoreKit

class DetailFutureViewController: UIViewController {

    @IBOutlet weak var contactFormButton: UIButton!
    @IBAction func contactFromButtonAction(_ sender: Any) {
        let url = NSURL(string: "https://swiftblog.tokyo/contactform/")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    @IBOutlet weak var reviewButton: UIButton!
    @IBAction func reviewButtonAction(_ sender: Any) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    @IBOutlet weak var imageBackgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpImageBackgroundView()

        setUpContactFormButton()

        setUpReviewButton()
    }
    func setUpImageBackgroundView() {
        imageBackgroundView.layer.cornerRadius = 10
        imageBackgroundView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        imageBackgroundView.layer.shadowOpacity = 0.6
        imageBackgroundView.layer.borderWidth = 0.1
        imageBackgroundView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
    }

    func setUpContactFormButton() {
        contactFormButton.layer.cornerRadius = 10
        contactFormButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        contactFormButton.layer.shadowColor = UIColor.gray.cgColor
        contactFormButton.layer.shadowOpacity = 0.6
        contactFormButton.layer.borderWidth = 0.1
        contactFormButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
    }

    func setUpReviewButton() {
        reviewButton.layer.cornerRadius = 10
        reviewButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        reviewButton.layer.shadowColor = UIColor.gray.cgColor
        reviewButton.layer.shadowOpacity = 0.6
        reviewButton.layer.borderWidth = 0.1
        reviewButton.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
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
