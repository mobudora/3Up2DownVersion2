//
//  DetailTextViewController.swift
//  HouseBook6
//
//  Created by Dora on 2022/05/31.
//

import UIKit

class DetailTextViewController: UIViewController {
    
    @IBOutlet weak var imageBackgroundView: UIView!
    
    @IBOutlet weak var detailIconImageView: UIImageView!
    
    @IBOutlet weak var detailTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpImageBackgroundView()

    }
    func setUpImageBackgroundView() {
        imageBackgroundView.layer.cornerRadius = 10
        imageBackgroundView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        imageBackgroundView.layer.shadowOpacity = 0.6
        imageBackgroundView.layer.borderWidth = 0.1
        imageBackgroundView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
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
